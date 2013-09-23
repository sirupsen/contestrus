class AddSubmissionIdToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :submission_id, :integer
  end
end
