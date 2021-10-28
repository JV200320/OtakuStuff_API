class UsersController < ApplicationController

  def search
    @users = User.all.where("nickname ILIKE '%#{params['q']}%'")
    render 'users/search'
  end

end
