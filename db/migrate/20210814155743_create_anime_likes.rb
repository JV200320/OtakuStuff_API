class CreateAnimeLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :anime_likes do |t|
      t.references :anime_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
