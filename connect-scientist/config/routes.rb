Rails.application.routes.draw do
  # devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :profiles, only: [:index, :show], controller: :profiles
      post 'profiles/:id/find_expert', to: 'profiles#find_expert'
    end
  end
end
