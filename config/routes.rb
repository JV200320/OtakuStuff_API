Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :animes do
    get '/', to: 'animes#index'
    get '/search', to: 'animes#search'
    get '/:anime_id', to: 'animes#show'
  end

  get 'favorites/:id', to: 'favorites#index'
  get 'anime/posts/:anime_id', to: 'anime_posts#index'
  get 'anime/posts/replies/:post_id', to: 'anime_posts#replies'

  namespace :interactions do
    patch 'favorites/:id/add/:anime_id', to: 'favorites#add_favorite'
    patch 'favorites/:id/remove/:anime_id', to: 'favorites#remove_favorite'
    post 'follow/:id', to: 'follows#create'
    delete 'unfollow/:id', to: 'follows#destroy'

    post 'anime/post/:anime_id', to: 'anime_posts#create'
    delete 'anime/post/:post_id', to: 'anime_posts#destroy'
    patch 'anime/post/:post_id', to: 'anime_posts#update'
  end

end
