class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  validates :token, presence: true
  validates :user_id, presence: true  # userが紐付いていなければ購入できない
  validates :item_id, presence: true  # itemが紐付いていなければ購入できない
  validates :postal_code, presence: { message: "can't be blank" }, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, :address, :phone_number, presence: true
  validates :phone_number, length: { in: 10..11 }, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }

  def item_price
    item.price
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    if order.persisted?
      ShippingAddress.create(
        postal_code: postal_code, 
        prefecture_id: prefecture_id, 
        city: city, 
        address: address, 
        building: building, 
        phone_number: phone_number, 
        order_id: order.id
      )
    end
  end

  private

  # item_idから関連する商品を取得するプライベートメソッドを追加
  def item
    Item.find_by(id: item_id)
  end
end