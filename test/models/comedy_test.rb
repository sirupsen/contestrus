require 'test_helper'
require 'comedy'

class GarbageJob
  def perform
  end
end

class ComedyTest < ActiveSupport::TestCase
  test "#inline true performs jobs to be worked off when queued" do
    Comedy << GarbageJob.new
    assert_equal 0, Comedy::Job.count
  end

  test "#inline false queues jobs" do
    begin
      Comedy.inline = false
      Comedy << GarbageJob.new
      assert_equal 1, Comedy::Job.count
    ensure
      Comedy.inline = true
    end
  end
end
