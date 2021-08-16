class CreatePagePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :page_posts do |t|
      t.references :page, null: false, foreign_key: true
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :kind, default: 0

      t.timestamps
    end
  end
end
