require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザ登録ができる時' do
      it 'すべての情報が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザ登録ができない時' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        expect(@user).to_not be_valid
      end

      it 'メールアドレスが必須であること' do
        @user.email = ''
        expect(@user).to_not be_valid
      end

      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        expect(another_user).to_not be_valid
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testexample.com'
        expect(@user).to_not be_valid
      end

      it 'パスワードが必須であること' do
        @user.password = ''
        @user.password_confirmation = ''
        expect(@user).to_not be_valid
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = 'pass'
        @user.password_confirmation = 'pass'
        expect(@user).to_not be_valid
      end

      it 'パスワードが半角英字のみでは登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        expect(@user).to_not be_valid
      end

      it 'パスワードが半角数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to_not be_valid
      end

      it 'パスワードが全角文字を含むと登録できないこと' do
        @user.password = 'Pass123全角'
        @user.password_confirmation = 'Pass123全角'
        expect(@user).to_not be_valid
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = 'password123'
        @user.password_confirmation = 'password124'
        expect(@user).to_not be_valid
      end

      # お名前(全角)のテストケース
      it 'お名前(全角)の名字が必須であること' do
        @user.last_name = ''
        expect(@user).to_not be_valid
      end

      it 'お名前(全角)の名前が必須であること' do
        @user.first_name = ''
        expect(@user).to_not be_valid
      end

      it 'お名前(全角)の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = 'yamada'
        expect(@user).to_not be_valid
      end

      it 'お名前(全角)の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'taro'
        expect(@user).to_not be_valid
      end

      # お名前カナ(全角)のテストケース
      it 'お名前カナ(全角)の名字が必須であること' do
        @user.last_name_kana = ''
        expect(@user).to_not be_valid
      end

      it 'お名前カナ(全角)の名前が必須であること' do
        @user.first_name_kana = ''
        expect(@user).to_not be_valid
      end

      it 'お名前カナ(全角)の名字は、全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'やまだ'
        expect(@user).to_not be_valid
      end

      it 'お名前カナ(全角)の名前は、全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'たろう'
        expect(@user).to_not be_valid
      end


      it '生年月日が必須であること' do
        @user.birth_date = ''
        expect(@user).to_not be_valid
      end
    end
  end
end
