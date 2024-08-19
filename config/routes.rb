Rails.application.routes.draw do

  root 'user/homes#top'

  # 顧客用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  namespace :user do
    root to: 'homes#top'
    get '/about', to: 'homes#about'
    resources :recipes, only: [:new, :index, :edit, :show, :create, :update, :destroy]
    resources :users, only: [:edit, :update, :index]
  end

 namespace :admin do
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
