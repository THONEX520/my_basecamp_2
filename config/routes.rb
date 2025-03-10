Rails.application.routes.draw do
  devise_for :users
  resources :projects
  #get "home/index"
  get "home/about"
  #root "home#index"
  root "projects#index"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    get "users/index"
    get "users/show"
    get "users/edit"
    get "users/update"
    get "users/destroy"
    resources :users, only: [:index, :show, :edit, :update, :destroy]do
    member do
      patch :set_admin
      patch :remove_admin
      end
    end
  end
end

