Rails.application.routes.draw do
  devise_for :users
  resources :users

  resources :posts do
    resources :opinions
  end
  get '/user' => "posts#index", :as => :user_root
  root 'posts#index'
end
