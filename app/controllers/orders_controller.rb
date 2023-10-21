class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_form = OrderForm.new
    # binding.pry
  end

def create
  @order_form = OrderForm.new(order_params)
  if @order_form.valid?
    pay_item
    @order_form.save
    return redirect_to root_path
  else
    Rails.logger.debug "DEBUG: Validation failed. Errors: #{@order_form.errors.full_messages}"
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    render 'index', status: :unprocessable_entity
  end
end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index  # 追加
    if current_user.id == @item.user_id  # 出品者であれば
      redirect_to root_path              # トップページにリダイレクト
    end
  end

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :price, :token).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
