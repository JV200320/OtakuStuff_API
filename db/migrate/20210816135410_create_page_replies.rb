class CreatePageReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :page_replies do |t|
      t.integer :comment_id
      t.integer :reply_id

      t.timestamps
    end
  end
end
