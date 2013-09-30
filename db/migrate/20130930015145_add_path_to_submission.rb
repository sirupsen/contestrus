class AddPathToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :path, :string
  end
end
