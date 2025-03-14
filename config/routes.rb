Rails.application.routes.draw do
  get "discussion_threads/new"
  get "discussion_threads/create"
  get "discussion_threads/edit"
  get "discussion_threads/update"
  get "discussion_threads/destroy"
  devise_for :users

  resources :projects do
    resources :attachments, only: [:create, :destroy]
    resources :discussion_threads, except: [:index, :show]
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
