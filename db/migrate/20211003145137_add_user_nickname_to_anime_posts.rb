class AddUserNicknameToAnimePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :anime_posts, :user_nickname, :string
  end
end
