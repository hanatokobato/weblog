Rails.application.routes.draw do
  root "static_pages#show", page_type: "home"

  get "static_pages/*page_type", to: "static_pages#show", as: "static_pages"

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
end
