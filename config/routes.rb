Rails.application.routes.draw do



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
    get '/users/check', to: 'users#check',as: 'user_check'
    patch '/users/withdraw',to: 'users#withdraw', as: 'user_withdraw'
    get "/search", to: "searches#search"

    resources :users, only: [:edit, :update, :index, :show] do
      member do
       get :favorites
      end
    end
    resources :recipes, only: [:new, :index, :edit, :show, :create, :update, :destroy] do
      resources :recipe_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
   end
  end

 namespace :admin do
    root to: 'admin/homes#top'
    resources :users, only: [:index, :show, :edit, :update]
  end

  root to: 'user/homes#top'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
