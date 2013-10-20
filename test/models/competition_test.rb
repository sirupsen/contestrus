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

  test "open? returns whether a competition is open" do
    competition = competitions(:past)
    start, ending = competition.start_at, competition.end_at
    assert competition.open?(start + 10.minutes)
    assert competition.open?(start)
    assert competition.open?(ending)
    refute competition.open?(ending + 10.minutes)
    refute competition.open?(start - 10.minutes)
  end

  test "open? returns true when competition is not time limited" do
    assert competitions(:open).open?
  end

  test "always_open? returns true when competition is not time limited" do
    assert competitions(:open).always_open?
  end

  test "always_open? returns false when competition is not time limited" do
    refute competitions(:past).always_open?
  end

  test "#participating? returns true if user has submitted successfully to contest" do
    user = users(:sirup)
    Submission.create(task: tasks(:hello_world), user: user, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal true, competitions(:open).participating?(user)
  end

  test "#participating? returns true if user has submitted insuccessfully to contest" do
    user = users(:sirup)
    Submission.create(task: tasks(:hello_world), user: user, 
                      source: 'puts "failed"', path: "hello.rb")

    assert_equal true, competitions(:open).participating?(user)
  end

  test "#participating? returns false if user has not submitted to contest" do
    user = users(:sirup)
    assert_equal false, competitions(:open).participating?(user)
  end

  test "#leaderboard should return an empty array when no user have submitted to a competition" do
    assert_equal [], competitions(:open).leaderboard 
  end

  test "#leaderboard should return single user with submission" do
    competition = competitions(:open)
    user = users(:sirup)
    Submission.create(task: tasks(:hello_world), user: user, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [user], competitions(:open).leaderboard 
  end

  test "#leaderboard should return user with most submissions first" do
    competition = competitions(:open)

    user = users(:sirup)
    Submission.create(task: tasks(:hello_world), user: user, 
                      source: 'puts "Hello World"', path: "hello.rb")
    Submission.create(task: tasks(:sum), user: user, 
                      source: 'puts $stdin.gets.split(" ").map(&:to_i).reduce(:+)', path: "sum.rb")

    bob = users(:bob)
    Submission.create(task: tasks(:hello_world), user: bob, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [user, bob], competitions(:open).leaderboard 
  end

  test "#leaderboard should return user with earliest submission first at tie" do
    competition = competitions(:open)

    bob = users(:bob)
    Submission.create(task: tasks(:hello_world), user: bob, 
                      source: 'puts "Hello World"', path: "hello.rb")

    sleep 1

    sirup = users(:sirup)
    Submission.create(task: tasks(:hello_world), user: sirup, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [bob, sirup], competitions(:open).leaderboard 
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
