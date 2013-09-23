class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :source
      t.string :lang
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end
  end
end
