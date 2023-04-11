Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create, :update, :destroy] do
        resources :subscriptions, only: [:create, :index, :update]
      end
    end
  end
end
