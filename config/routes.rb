Rails.application.routes.draw do
  root "static_pages#show", page_type: "home"

  get "static_pages/*page_type", to: "static_pages#show", as: "static_pages"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :users, only: %i(index show) do
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

  get "tags/:tag_name", to: "posts#index", as: "tag"

  get "statistics", to: "statistics#index", as: "statistics"
  get "statistic", to: "statistics#statistic", as: "statistic"
  get "statistic/users", to: "statistics#users", as: "statistic_users"
  get "statistic/posts", to: "statistics#posts", as: "statistic_posts"
  get "statistic/active_users", to: "statistics#active_users",
    as: "statistic_active_users"
  get "statistic/common_posts", to: "statistics#common_posts",
    as: "statistic_common_posts"
end
