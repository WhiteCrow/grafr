Rails.application.routes.draw do
  root to: 'visitors#index'
  # devise_for :users
  # resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :courses do
    get "attendence", "class_performance", "homework", "quiz", "mid_term", on: :member
  end
end
