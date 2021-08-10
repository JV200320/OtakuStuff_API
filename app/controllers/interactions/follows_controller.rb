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
    
  end
end
