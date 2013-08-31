class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
