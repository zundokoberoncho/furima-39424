require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録/ユーザー情報' do
    # ここでUserオブジェクトを作成しておく
    let(:user) { User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01') }

    it 'ニックネームが必須であること' do
      user.nickname = ''
      expect(user).to_not be_valid
    end

    it 'メールアドレスが必須であること' do
      user.email = ''
      expect(user).to_not be_valid
    end

    it 'メールアドレスが一意性であること' do
      user.save
      another_user = User.new(email: 'test@example.com')
      expect(another_user).to_not be_valid
    end

    it 'メールアドレスは、@を含む必要があること' do
      user.email = 'testexample.com'
      expect(user).to_not be_valid
    end

    it 'パスワードが必須であること' do
      user.password = ''
      user.password_confirmation = ''
      expect(user).to_not be_valid
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      user.password = 'pass'
      user.password_confirmation = 'pass'
      expect(user).to_not be_valid
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      user.password = 'password'
      user.password_confirmation = 'password'
      expect(user).to_not be_valid
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      user.password = 'password123'
      user.password_confirmation = 'password124'
      expect(user).to_not be_valid
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      user.last_name = ''
      user.first_name = ''
      expect(user).to_not be_valid
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user.last_name = 'yamada'
      user.first_name = 'taro'
      expect(user).to_not be_valid
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      user.last_name_kana = ''
      user.first_name_kana = ''
      expect(user).to_not be_valid
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      user.last_name_kana = 'やまだ'
      user.first_name_kana = 'たろう'
      expect(user).to_not be_valid
    end

    it '生年月日が必須であること' do
      user.birth_date = ''
      expect(user).to_not be_valid
    end
  end
end
