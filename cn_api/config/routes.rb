Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      get "info", controller: :info, action: :index
      get "categories", controller: :categories, action: :index
      resources :searches, only: [:index, :show, :create] do
        member do
          get :resend_email
        end
      end
    end
  end

  get "show_404", controller: :routing_errors, action: :show_404

  match '*path', to: 'routing_errors#show_404', via: :all
end
