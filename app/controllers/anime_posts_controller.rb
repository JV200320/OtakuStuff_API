class AnimePostsController < ApplicationController

  def index
    @posts = AnimePost.where(anime_id: params['anime_id'])
  end

  def replies
    post = AnimePost.find(params['post_id'])
    @replies = post.replies
  end

end
