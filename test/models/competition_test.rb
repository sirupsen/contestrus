require 'test_helper'

class CompetitionTest < ActiveSupport::TestCase
  test "creates a competition" do
    assert_difference "Competition.count", +1 do
      Competition.create(valid_params)
    end
  end

  test "competition requires a name" do
    competition = Competition.new(valid_params.merge(name: nil))
    assert_invalid competition
  end

  test "does not allow only start_at" do
    competition = Competition.new(valid_params.merge(start_at: nil))
    assert_invalid competition
  end

  test "does not allow only end_at" do
    competition = Competition.new(valid_params.merge(end_at: nil))
    assert_invalid competition
  end

  private
  def valid_params
    {
      name: "Algofy #1",
      start_at: Time.now,
      end_at: Time.now + 2.hours
    }
  end
end
