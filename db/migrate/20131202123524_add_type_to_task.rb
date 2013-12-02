class AddTypeToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :scoring, :string, default: "acm"
  end
end
