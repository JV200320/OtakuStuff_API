module Interactions
  class AnimePostsController < AuthenticatedController
    include Anime

    def create
      res = get_anime("/anime/#{params['anime_id']}")
      if res.key?("error")
        render json: {error: res['error']}
        return
      end
      animepost = AnimePost.create(content: params['content'], anime_id: params['anime_id'],
                       user_id: current_user['id'], user_nickname: current_user['nickname'],
                       user_image_url: url_for(current_user.avatar))
      animepost.save!
      render json: {success: true}
    end
    
    def destroy
      begin
        post = AnimePost.find(params['post_id'])
      rescue
        render json: {error: "No post with this id"}
        return
      end
      return render json: {error: "Access forbidden"} if post['user_id'] != current_user['id']
      
      post.destroy!
      render json: {success: true}
    end

    def update
      begin
        post = AnimePost.find(params['post_id'])
      rescue
        render json: {error: "No post with this id"}
        return
      end
      if post['created_at'] <= post['created_at']+3600
        post['content'] = params['content']
        post.save!
        render json: {success: true}
        return
      end
      render json: {error: "This post is too old to be edited"}
    end
    
    def reply
      post = AnimePost.find(params['post_id'])
      post.reply(current_user, params['content'])
    end

    def like
      post = AnimePost.find(params['post_id'])
      current_user.anime_like_post(post)
      render json: {success: true}
    end
    
    def unlike
      post = AnimePost.find(params['post_id'])
      current_user.undo_anime_like_post(post)
      render json: {success: true}
    end


  end
end
