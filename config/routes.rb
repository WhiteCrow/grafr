Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'
  # devise_for :users
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :grades, only: [:show]
  resources :courses do
    get "attendence", "class_performance", "homework", "quiz", "mid_term", on: :member
    post "recalculate_score", on: :member
  end
end
