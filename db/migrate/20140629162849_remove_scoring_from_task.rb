class RemoveScoringFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :scoring
  end
end
