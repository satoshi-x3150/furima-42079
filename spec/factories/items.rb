FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { 'これはテスト用の商品です。' }
    price { 1000 }
    category_id { 2 } # 1以外（バリデーションで「---」は1となっているため）
    condition_id { 2 }
    shipping_fee_id { 2 }
    prefecture_id { 2 }
    shipping_time_id { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
