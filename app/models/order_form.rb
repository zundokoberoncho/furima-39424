class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token, :price

  validates :token, presence: true
  validates :postal_code, presence: { message: "can't be blank" }, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :city, :address, :phone_number, presence: true
  validates :phone_number, length: { in: 10..11 }, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id, price: price)
    if order.persisted?  # Orderが正常に保存されたかをチェック
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
end