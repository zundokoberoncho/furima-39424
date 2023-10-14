# /Users/708/projects/furima-39424/app/controllers/items_controller.rb

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
    puts "==== Debug Start ===="
    puts "Selected Item: #{@item.inspect}"
    puts "==== Debug End ===="
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :sales_status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
      :price, :image
    )
  end
end