class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
  
      order = Order.new(
        user_id: current_user.id,
        item_id: params[:item_id]
      )
  
      if order.save(validate: false) # priceのバリデーションを無効にして保存
        ShippingAddress.create(
          postal_code: @order_form.postal_code,
          prefecture_id: @order_form.prefecture_id,
          city: @order_form.city,
          address: @order_form.address,
          building: @order_form.building,
          phone_number: @order_form.phone_number,
          order_id: order.id
        )
        redirect_to root_path
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render 'index', status: :unprocessable_entity
      end
    else
      render 'index'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def order_params
    params.require(:order_form).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :address,
      :building,
      :phone_number,
      :token
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id]
    )
  end

  def pay_item
    amount = @item.price
  
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: amount,                # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'               # 通貨の種類（日本円）
    )
  end
end
