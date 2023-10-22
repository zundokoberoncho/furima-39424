class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :user_id  # userが紐付いていなければ購入できない
    validates :item_id  # itemが紐付いていなければ購入できない
    validates :city
    validates :address
    validates :phone_number  # ← この行を追加
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :phone_number, length: { in: 10..11 }, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }, if: -> { phone_number.present? }

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