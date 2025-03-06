require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      
      it 'メールアドレスが重複している場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      
      it 'パスワードが6文字未満だと登録できない' do
        @user.password = 'pass1'
        @user.password_confirmation = 'pass1'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      
      it '誕生日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      
      it 'ファーストネームが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'ラストネームが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'カナでのファーストネームが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'ラストトネームが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
    end
  end
end