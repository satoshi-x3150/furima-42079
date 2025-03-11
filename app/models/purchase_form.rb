class PurchaseForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :item_id, :user_id, :token

  # バリデーション
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "はハイフンを含んだ正しい形式で入力してください" }
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁または11桁の数字を入力してください" }
    validates :item_id
    validates :user_id
    validates :token
  end

  # 保存処理
  def save
    # 購入情報を保存し、変数 purchase に代入する
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    
    # 発送先情報を保存する
    ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      purchase_record_id: purchase_record.id
    )
  end
end
