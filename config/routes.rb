Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :attachments, only: [:create, :destroy]
    resources :discussion_threads, only: [:show, :new, :create, :edit, :update, :destroy]do
    resources :messages, only: [:new, :create, :edit, :update, :destroy]
  end
end

  get "home/about"
  root "projects#index"
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch :set_admin
        patch :remove_admin
      end
    end
  end
end
