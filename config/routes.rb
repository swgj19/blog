Rails.application.routes.draw do
  get '/user' => "posts#index", :as => :user_root
  get '/users', to: redirect('/users/sign_up')
  devise_for :users
  resources :users

  resources :posts do
    resources :opinions
  end
  
  root 'posts#index'
end
