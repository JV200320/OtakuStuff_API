module Interactions
  class AnimePostsController < AuthenticatedController
    include Anime

    def create
      res = get_anime("/anime/#{params['anime_id']}")
      if res.key?("error")
        render json: {error: res['error']}
        return
      end
      AnimePost.create(content: params['content'], anime_id: params['anime_id'], user_id: current_user['id'])
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
    


  end
end
