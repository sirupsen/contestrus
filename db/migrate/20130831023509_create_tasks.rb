class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :competition_id
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
