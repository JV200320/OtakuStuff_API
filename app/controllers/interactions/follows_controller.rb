module Interactions
  class FollowsController < AuthenticatedController

    def create
      user = User.find(params['id'])
      return if user.nil?

      if user != current_user
        current_user.follow!(user) unless current_user.following?(user)
      end
    end
    
    def destroy
      user = User.find(params['id'])
      unless user.nil?
        current_user.unfollow!(user) if current_user.following?(user)
      end
    end
    
    def page_create
      page = Page.find(params['id'])
      return if page.nil?

      current_user.follow_page!(page) unless current_user.following_page?(page)
    end
    
    def page_destroy
      page = Page.find(params['id'])
      unless page.nil?
        current_user.unfollow_page!(page) if current_user.following_page?(page)
      end
    end
    
  end
end
