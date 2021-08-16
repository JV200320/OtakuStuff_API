class CreatePageLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :page_likes do |t|
      t.references :page_post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
