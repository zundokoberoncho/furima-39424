FactoryBot.define do
  factory :shipping_address do
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address { "MyString" }
    building { "MyString" }
    phone_number { "MyString" }
    order { nil }
  end
end
