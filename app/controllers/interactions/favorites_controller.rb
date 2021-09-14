require 'json'

module Interactions
  class FavoritesController < AuthenticatedController
    include Anime

    def add_favorite
      res = get_anime("/anime/#{params['anime_id']}")
      if res.key?("error")
        render json: {error: res['error']}
      else
        res = {mal_id: res['mal_id'], image_url: res['image_url'], title: res['title']}.to_json
        @user = User.find(params['id'])
        if current_user == @user && !@user['favorites'].include?(res)
          @user['favorites'].unshift(res)
          save_user!
        end
      end
    end
  
    def remove_favorite
      @user = User.find(params['id'])
      if current_user == @user
        @user['favorites'].delete_if { |json| JSON.parse(json)['mal_id'] == params['anime_id'].to_i}
        save_user!
      end
    end

    private

    def save_user!
      @user.save!
      @user.reload
      render 'interactions/update_favorite.json.jbuilder'
    rescue => e
      render json: {error: e}
    end
  end
end
