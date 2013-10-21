class CleanUpIndexes < ActiveRecord::Migration
  def change
    remove_index :users, :id

    add_index :submissions, [:task_id, :user_id]
    add_index :submissions, [:task_id, :passed]

    add_index :tasks, :competition_id

    add_index :test_cases, :task_id

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
