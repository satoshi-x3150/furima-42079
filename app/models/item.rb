class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ActiveHash のアソシエーション設定
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_time

  # バリデーション設定
  validates :name, :description, :image, presence: true

  # 価格のバリデーション
  validates :price, presence: true,
                    numericality: { 
                      only_integer: true, 
                      greater_than_or_equal_to: 300, 
                      less_than_or_equal_to: 9_999_999, 
                      message: "は300〜9,999,999円で入力してください" 
                    }

  # ActiveHash を使ったプルダウンのバリデーション
  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_time_id
  end
end
