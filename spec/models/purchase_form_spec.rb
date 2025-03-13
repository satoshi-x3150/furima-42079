require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: @user.id, item_id: @item.id) 
  end

  describe '購入情報の保存' do
    context '購入ができるとき' do
      it '必要な情報が全て揃っていれば購入できる' do
        expect(@purchase_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @purchase_form.building_name = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '購入ができないとき' do
      it '郵便番号が空では購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '都道府県が空では購入できない' do
        @purchase_form.prefecture_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '都道府県が1では購入できない' do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '市区町村が空では購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @purchase_form.address = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number は10桁または11桁の数字を入力してください")
      end

      it '電話番号が12桁以上では購入できない' do
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number は10桁または11桁の数字を入力してください")
      end

      it '電話番号に数字以外が含まれていると購入できない' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number は10桁または11桁の数字を入力してください")
      end

      it 'user_idが空では購入できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では購入できない' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
