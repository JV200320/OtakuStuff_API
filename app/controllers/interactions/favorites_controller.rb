module Interactions
  class FavoritesController < AuthenticatedController
    include Anime

    def add_favorite
      res = get_anime("/anime/#{params['anime_id']}")
      if res.key?("error")
        render json: {error: res['error']}
      else
        @user = User.find(params['id'])
        if current_user == @user && !@user['favorites'].include?(params['anime_id'])
          @user['favorites'].push(params['anime_id'])
          save_user!
        end
      end
    end
  
    def remove_favorite
      @user = User.find(params['id'])
      if current_user == @user
        @user['favorites'].delete(params['anime_id'])
        save_user!
      end
    end

    private

    def save_user!
      @user.save!
      @user.reload
      render json: {success: true}
    rescue => e
      render json: {error: e}
    end
  end
end
