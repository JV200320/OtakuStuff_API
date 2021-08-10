Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :animes do
    get '/', to: 'animes#index'
    get '/search', to: 'animes#search'
    get '/:anime_id', to: 'animes#show'
  end

  get ':id/favorites', to: 'favorites#index'

  namespace :interactions do
    patch 'favorites/:id/add/:anime_id', to: 'favorites#add_favorite'
    patch 'favorites/:id/remove/:anime_id', to: 'favorites#remove_favorite'
    post 'follow/:id', to: 'follows#create'
    delete 'unfollow/:id', to: 'follows#destroy'
  end

end
