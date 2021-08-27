class UsersController < ApplicationController

  def search
    @users = User.all.where("nickname ILIKE '%#{params['search']}%'")
  end

end
