class UsersController < ApplicationController

  def search
    @users = User.all.where("nickname ILIKE '%#{params['search']}%'")
    render 'users/search.json.jbuilder'
  end

end
