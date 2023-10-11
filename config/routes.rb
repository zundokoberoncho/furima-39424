Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  # 他のルート設定
end