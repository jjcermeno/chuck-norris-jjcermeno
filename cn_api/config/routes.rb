Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    namespace :v1 do
      get "categories", controller: :categories, action: :index
    end
  end

  match '*path', to: 'routing_errors#show_404', via: :all
end
