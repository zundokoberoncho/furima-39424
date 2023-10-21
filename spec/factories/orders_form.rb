FactoryBot.define do
  factory :order_form do
    user_id { 1 }
    item_id { 1 }
    token { "tok_abcdefghijk00000000000000000" }
    postal_code { "123-4567" }
    prefecture_id { 2 }
    city { "テスト市" }
    address { "テスト1-1-1" }
    building { "テストビル" }
    phone_number { "09012345678" }
  end
end