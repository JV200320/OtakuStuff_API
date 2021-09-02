class AddOwnerNicknameToPages < ActiveRecord::Migration[6.1]
  def change
    add_column :pages, :owner_nickname, :string
  end
end
