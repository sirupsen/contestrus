class TestGroup < ActiveRecord::Base
  belongs_to :task
  has_many :test_cases, foreign_key: :group_id
end
