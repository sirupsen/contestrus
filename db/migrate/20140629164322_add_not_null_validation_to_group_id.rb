class AddNotNullValidationToGroupId < ActiveRecord::Migration
  def change
    change_column :test_cases, :group_id, :integer, null: false
  end
end
