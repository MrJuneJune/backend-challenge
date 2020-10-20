Rails.application.routes.draw do
  # APIs
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Devise routes
      devise_for :users, skip: [:sessions, :registrations]
      devise_scope :api_v1_user do
        # Sessions
        post 'sessions/create' => 'sessions#create'
        post 'sessions/destroy' => 'sessions#destroy'

        # Users 
        post 'registrations/create' => 'registrations#create'
        post 'registrations/destroy' => 'registrations#destroy'
      end

      # Profile routes
      resources :profiles, only: [:index, :show], controller: :profiles
      post 'profiles/:id/find_expert', to: 'profiles#find_expert'
    end
  end
end
