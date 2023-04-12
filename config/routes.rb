# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[create update destroy] do
        resources :subscriptions, only: %i[create index update]
      end
    end
  end
end
