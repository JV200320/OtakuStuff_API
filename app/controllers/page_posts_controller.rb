class PagePostsController < ApplicationController

  def index
    @posts = PagePost.where(page_id: params['page_id'], kind: "post")
  end

  def replies
    post = PagePost.find(params['post_id'])
    @replies = post.replies
  end

end
