FactoryBot.define do
  factory :shipping_address do
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address { "MyString" }
    building_name { "MyString" }
    phone_number { "MyString" }
    purchase_record { nil }
  end
end
