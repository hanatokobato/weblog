Rails.application.routes.draw do
  root "static_pages#show", page_type: "home"

  get "static_pages/*page_type", to: "static_pages#show", as: "static_pages"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users, only: %i(index show destroy) do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  resources :relationships, only: %i(create destroy)

  get "tags/:tag_name", to: "posts#index", as: :tag
end
