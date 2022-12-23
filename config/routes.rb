Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: :show
  resources :posts, only: %i[index show new create] do
    resources :comments, only: :create
    collection do
      get :my_posts
    end
  end
end
