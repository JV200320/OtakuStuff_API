class CreatePages < ActiveRecord::Migration[6.1]
  def change
    create_table :pages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :image
      t.string :title
      t.text :description, default: "Ainda não temos uma descrição."

      t.timestamps
    end
  end
end
