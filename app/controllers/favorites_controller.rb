class FavoritesController < ApplicationController

  def index
    user = User.find(params['id'])
    if user.nil?
      return
    end
    @favorites = user.favorites
  end
end
