class DropDeadTables < ActiveRecord::Migration
  def change
    drop_table :languages
    drop_table :participations

    remove_column :tasks, :type
    remove_column :submissions, :language_id
    remove_column :competitions, :body
  end
end
