class RemoveEvaluations < ActiveRecord::Migration
  def change
    drop_table :evaluations
  end
end
