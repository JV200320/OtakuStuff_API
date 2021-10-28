class AddUserImageUrlToAnimePosts < ActiveRecord::Migration[6.1]
  def change
    add_column :anime_posts, :user_image_url, :string
  end
end
