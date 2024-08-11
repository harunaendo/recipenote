Rails.application.routes.draw do
  namespace :user do
    get 'recipes/new'
    get 'recipes/index'
    get 'recipes/edit'
    get 'recipes/show'
  end
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
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
