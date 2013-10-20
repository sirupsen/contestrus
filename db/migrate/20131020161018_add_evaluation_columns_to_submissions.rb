class AddEvaluationColumnsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :status, :string, default: "Pending"
    add_column :submissions, :body, :text
    add_column :submissions, :passed, :boolean, default: false
  end
end
