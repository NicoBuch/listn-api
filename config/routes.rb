ListnApi::Application.routes.draw do

  # root to: 'application#index'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  api_version(module: 'api/v1', path: {value: 'api/v1'}) do
    resources :users, only: [:index, :update], param: :spotify_id do
    end
  end
end
