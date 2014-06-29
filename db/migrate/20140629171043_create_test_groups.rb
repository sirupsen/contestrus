class CreateTestGroups < ActiveRecord::Migration
  def change
    create_table :test_groups do |t|
      t.integer :points, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
