class AddTaskIdToGroup < ActiveRecord::Migration
  def change
    add_column :test_groups, :task_id, :integer, null: false, default: 100
  end
end
