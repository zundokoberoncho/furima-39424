class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :sales_status
  belongs_to :shipping_fee_status

  has_one_attached :image
  
  validates :image, presence: { message: "can't be blank" }
  validates :name, presence: { message: "can't be blank" }
  validates :description, presence: { message: "Info can't be blank" }
  
  validates :price, presence: { message: "can't be blank" },
            numericality: { 
              only_integer: true,
              greater_than: 299, 
              less_than: 10_000_000,
              message: "is out of setting range"
            },
            format: { with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters" }

  validates :category_id, presence: { message: "Category can't be blank" }, numericality: { other_than: 1, message: "can't be blank" }
  validates :sales_status_id, presence: { message: "can't be blank" }
  validate :sales_status_id_must_be_other_than_one

  validates :shipping_fee_status_id, presence: { message: "Shipping fee status can't be blank" }, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, presence: { message: "Prefecture can't be blank" }, numericality: { other_than: 1, message: "can't be blank" }
  validates :scheduled_delivery_id, presence: { message: "Scheduled delivery can't be blank" }, numericality: { other_than: 1, message: "can't be blank" }

  private

  def sales_status_id_must_be_other_than_one
    if sales_status_id == 1
      errors.add(:sales_status_id, "must be other than 1")
    end
  end
end
