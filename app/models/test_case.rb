class TestCase < ActiveRecord::Base
  belongs_to :task
  belongs_to :group, class_name: TestGroup
end
