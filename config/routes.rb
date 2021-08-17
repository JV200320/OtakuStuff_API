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
  get 'page/posts/:page_id', to: 'page_posts#index'
  get 'page/posts/replies/:post_id', to: 'page_posts#replies'
  get 'pages', to: 'pages#index'
  get 'pages/search', to: 'pages#search'
  get 'pages/followers/:id', to: 'pages#followers'

  namespace :interactions do
    patch 'favorites/:id/add/:anime_id', to: 'favorites#add_favorite'
    patch 'favorites/:id/remove/:anime_id', to: 'favorites#remove_favorite'
    post 'follow/:id', to: 'follows#create'
    delete 'unfollow/:id', to: 'follows#destroy'
    post 'follow/page/:id', to: 'follows#page_create'
    delete 'unfollow/page/:id', to: 'follows#page_destroy'

    post 'anime/post/:anime_id', to: 'anime_posts#create'
    post 'anime/post/reply/:post_id', to: 'anime_posts#reply'
    delete 'anime/post/:post_id', to: 'anime_posts#destroy'
    patch 'anime/post/:post_id', to: 'anime_posts#update'
    
    post 'page/post/:page_id', to: 'page_posts#create'
    post 'page/post/reply/:post_id', to: 'page_posts#reply'
    delete 'page/post/:post_id', to: 'page_posts#destroy'
    patch 'page/post/:post_id', to: 'page_posts#update'

    post 'pages', to: 'pages#create'
    delete 'pages/:page_id', to: 'pages#destroy'
    patch 'pages/:page_id', to: 'pages#update'
  end

end
