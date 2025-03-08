require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品ができる場合' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができない場合' do

      it '画像が無いと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'ユーザーが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end

      it '商品名が空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが未選択（id:1）だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category を選択してください")
      end
      
      it '商品の状態が未選択（id:1）だと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition を選択してください")
      end

      it '配送料の負担が未選択（id:1）だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee を選択してください")
      end

      it '発送元の地域が未選択（id:1）だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture を選択してください")
      end
      
      it '発送までの日数が未選択（id:1）だと出品できない' do
        @item.shipping_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping time を選択してください")
      end
      
      it '価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      
      it '価格が300円未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300〜9,999,999円で入力してください")
      end
      
      it '価格が10,000,000円以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300〜9,999,999円で入力してください")
      end
      
      it '価格が半角数値でないと出品できない' do
        @item.price = '１０００' # 全角数字を設定
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は300〜9,999,999円で入力してください")
      end
      
    
    end
    
  end
end