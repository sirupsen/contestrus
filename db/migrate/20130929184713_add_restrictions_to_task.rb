class AddRestrictionsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :restrictions, :text
  end
end
