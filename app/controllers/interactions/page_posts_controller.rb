module Interactions
  class PagePostsController < AuthenticatedController
    
    def create
      return render json: {error: "Page id not found."} if Page.find(params['page_id']).nil?
      PagePost.create(content: params['content'], page_id: params['page_id'], user_id: current_user['id'])
      render json: {success: true}
    end
    
    def destroy
      begin
        post = PagePost.find(params['post_id'])
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
        post = PagePost.find(params['post_id'])
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
      post = PagePost.find(params['post_id'])
      post.reply(current_user, params['content'])
    end
    

  end
end
