class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to root_path
    else
      puts "==== Debug Start ===="
      puts "Item Params: #{item_params.inspect}"
      puts "Sales Status ID: #{@item.sales_status_id}"
      puts "Item Valid?: #{@item.valid?}"
      puts "Item Errors: #{@item.errors.full_messages}"
      puts "==== Debug End ===="
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      # 成功時の処理
      redirect_to item_path(@item)
    else
      # 失敗時の処理
      puts "==== Debug Update Failed ===="
      puts @item.errors.full_messages
      flash.now[:alert] = @item.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path, alert: '削除に失敗しました'
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :sales_status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
      :price, :image
    )
  end
end