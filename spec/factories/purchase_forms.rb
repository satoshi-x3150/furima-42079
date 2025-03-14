FactoryBot.define do
  factory :purchase_form do
    postal_code    { '123-4567' } # ハイフンありの郵便番号
    prefecture_id  { 2 } # 1以外を設定（バリデーションで1は選択不可）
    city          { '横浜市' }
    address       { '青山1-1-1' }
    building_name { '柳ビル103' } # 建物名は空でも良い
    phone_number  { '09012345678' } # 10桁 or 11桁の半角数字
    token         { 'tok_abcdefghijk00000000000000000' } # ダミーのトークン
  end
end
