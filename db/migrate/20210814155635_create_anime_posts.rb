class CreateAnimePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :anime_posts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :anime_id
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
