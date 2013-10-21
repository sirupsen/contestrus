class AddSessionHashToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :session_hash, :string

    execute "UPDATE users SET session_hash = '123deadbeef'"

    change_column :users, :session_hash, :string, null: false
  end
end
