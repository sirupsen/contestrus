class AddComedyJobs < ActiveRecord::Migration
  def change
    create_table :comedy_jobs do |t|
      t.string :class_name, null: false
      t.text   :ivars,      null: false

      t.timestamps
    end
  end
end
