class CreatePageRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :page_relationships do |t|
      t.references :page, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
