class AddBodyToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :body, :text
  end
end
