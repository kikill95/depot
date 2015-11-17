Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resource :user
  resource :session, only: [:new, :create, :destroy]
  root 'welcome#index'
  get 'user/confirm', to: 'users#confirm'
end
