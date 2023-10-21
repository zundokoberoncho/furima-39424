require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    # puts "Created User: #{user.inspect}"  # ログを追加
    item = FactoryBot.create(:item, user: user)
    # puts "Created Item: #{item.inspect}"  # ログを追加
    @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
    # puts "Order Form: #{@order_form.inspect}"  # ログを追加
  end

  describe '購入情報の保存' do
    # 正常系
    context '商品購入ができる時' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    # 異常系
    context '商品購入ができない時' do
      it 'クレジットカード情報が必須である' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が必須である' do
        @order_form.postal_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能であること' do
        @order_form.postal_code = "123456"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end

      it '都道府県が必須である' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が必須である' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須である' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が必須である' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能である' do
        @order_form.phone_number = "012345678"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end
    end
  end
end