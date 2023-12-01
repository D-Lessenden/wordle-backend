Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do 
    namespace :v1 do
      resources :sessions, only: [:create, :destroy]
      resources :users do
          resources :game_history #, only: [:show]
          resources :game do 
            post 'play', on: :member
            get 'play', on: :member
            patch 'update', on: :member
          end
      end 
      # resources :users
    end 
  end
end

# resources :game, only: [:show]


# namespace :api do
#   namespace :v1 do
#     resources :users, only: [] do
#       resources :game_histories, only: [:show]
#     end
#   end
# end


      # namespace :users do 
      #   get 'users/:id/game_history'
      # end 
      # get 'users/:id/game_history'
      # resources :games
      # resources :game_history