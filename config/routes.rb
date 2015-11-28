Rails.application.routes.draw do
  resource :user
  resource :session, only: [:new, :create, :destroy]
  root 'welcome#index'
  match 'categories/:slug' => 'welcome#index', via: :get, as: 'categories'
  resources :users do
    get :confirm, on: :member
  end

  namespace :admin do
    resources :products
    resources :categories
  end
end
