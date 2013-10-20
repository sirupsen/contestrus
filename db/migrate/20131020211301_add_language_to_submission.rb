class AddLanguageToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :language, :string
  end
end
