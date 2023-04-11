Rails.application.routes.draw do
  devise_for :users

  resources :blog_posts

  # Defines the root path route ("/")
   root "blog_posts#index"
end
