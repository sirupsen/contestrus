class NotNullConstraints < ActiveRecord::Migration
  def change
    change_column :comedy_jobs,   :created_at,      :datetime,  null: false
    change_column :comedy_jobs,   :updated_at,      :datetime,  null: false

    change_column :competitions,  :name,            :string,    null: false
    change_column :competitions,  :created_at,      :datetime,  null: false
    change_column :competitions,  :updated_at,      :datetime,  null: false

    change_column :submissions,   :source,          :text,      null: false
    change_column :submissions,   :task_id,         :integer,   null: false
    change_column :submissions,   :user_id,         :integer,   null: false
    change_column :submissions,   :created_at,      :datetime,  null: false
    change_column :submissions,   :updated_at,      :datetime,  null: false
    change_column :submissions,   :path,            :string,    null: false
    change_column :submissions,   :status,          :string,    null: false
    change_column :submissions,   :language,        :string,    null: false

    change_column :tasks,         :competition_id,  :integer,   null: false
    change_column :tasks,         :name,            :string,    null: false
    change_column :tasks,         :created_at,      :datetime,  null: false
    change_column :tasks,         :updated_at,      :datetime,  null: false
    change_column :tasks,         :restrictions,    :text,      null: false, default: ""

    change_column :test_cases,    :input,           :text,      null: false
    change_column :test_cases,    :output,          :text,      null: false
    change_column :test_cases,    :task_id,         :integer,   null: false
    change_column :test_cases,    :created_at,      :datetime,  null: false
    change_column :test_cases,    :updated_at,      :datetime,  null: false

    execute "UPDATE users SET admin = 'f' WHERE admin IS NULL"

    change_column :users,         :username,        :string,    null: false
    change_column :users,         :password_digest, :string,    null: false
    change_column :users,         :created_at,      :datetime,  null: false
    change_column :users,         :updated_at,      :datetime,  null: false
    change_column :users,         :email,           :string,    null: false
    change_column :users,         :admin,           :boolean,   null: false
  end
end
