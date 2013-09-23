class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.text :body
      t.boolean :passed

      t.timestamps
    end
  end
end
