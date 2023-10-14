FactoryBot.define do
  factory :item do
    name { 'Test Item' }
    description { 'This is a test item.' }
    category_id { 2 }
    shipping_fee_status_id { 2 }
    prefecture_id { 2 }
    scheduled_delivery_id { 2 }
    price { 500 }
    sales_status_id { 2 }
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('path/to/your/test/image.png'), filename: 'image.png', content_type: 'image/png')
    end
  end
end
