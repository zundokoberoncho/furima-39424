require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET #new' do
    context 'ログインしている場合' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user
      end

      it '200レスポンスが返ってくる' do
        get :new
        expect(response).to have_http_status '200'
      end
    end

  end 

  describe 'POST #create' do
    context 'ログインしている場合' do
      before do
        @user = FactoryBot.create(:user)
        sign_in @user  # Deviseのヘルパーメソッド
        
        # デバッグ情報を出力
        puts "Debug: @user = #{@user.inspect}"
      end

      it '出品が完了したら、トップページに遷移すること' do
        post :create, params: { item: FactoryBot.attributes_for(:item).merge(user_id: @user.id, image: fixture_file_upload('/Users/708/projects/furima-39424/app/assets/images/furima-logo-white.png')) }
        expect(response).to redirect_to root_path
      end

      it '出品が失敗したら、newテンプレートがレンダリングされること' do
        post :create, params: { item: FactoryBot.attributes_for(:item, name: '') }
        expect(response).to render_template :new
      end
    end

    context 'ログインしていない場合' do
      before do
        sign_out :user  # ログアウト
      end

      it 'ログインページにリダイレクトする' do
        post :create, params: { item: FactoryBot.attributes_for(:item) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
