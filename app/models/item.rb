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
end
