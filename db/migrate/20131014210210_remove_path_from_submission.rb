class RemovePathFromSubmission < ActiveRecord::Migration
  def change
    remove_column :submissions, :path
  end
end
