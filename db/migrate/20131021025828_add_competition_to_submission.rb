class AddCompetitionToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :competition_id, :integer
  end
end
