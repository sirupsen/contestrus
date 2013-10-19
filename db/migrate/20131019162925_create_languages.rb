class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.string :extension
      t.string :image
      t.string :build
      t.string :run

      t.timestamps
    end

    add_column :submissions, :language_id, :integer
    add_column :submissions, :path, :string
    remove_column :submissions, :lang
  end
end
