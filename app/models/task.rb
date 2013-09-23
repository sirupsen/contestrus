class Task < ActiveRecord::Base
  belongs_to :competition
  has_many :test_cases
end
