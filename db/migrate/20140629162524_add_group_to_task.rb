class AddGroupToTask < ActiveRecord::Migration
  def change
    add_column :test_cases, :group_id, :integer
  end
end
