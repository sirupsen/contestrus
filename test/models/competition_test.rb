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

  test "#leaderboard should return an empty array when no user have submitted to a competition" do
    assert_equal [], competitions(:open).leaderboard 
  end

  test "#leaderboard should return single user with submission" do
    competition = competitions(:ongoing)
    user = users(:sirup)

    Submission.create(task: tasks(:ongoing_hello_world), user: user, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [user], competition.leaderboard 
  end

  test "#leaderboard should return user with most submissions first" do
    competition = competitions(:ongoing)

    user = users(:sirup)
    Submission.create(task: tasks(:ongoing_hello_world), user: user, 
                      source: 'puts "Hello World"', path: "hello.rb")
    Submission.create(task: tasks(:ongoing_sum), user: user, 
                      source: 'puts $stdin.gets.split(" ").map(&:to_i).reduce(:+)', path: "sum.rb")

    bob = users(:bob)
    Submission.create(task: tasks(:ongoing_hello_world), user: bob, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [user, bob], competition.leaderboard
  end

  test "#leaderboard should return user with submissions with most total points" do
    competition = competitions(:ongoing)

    sirup = users(:sirup)
    submission = Submission.create(task: tasks(:ongoing_sum), user: sirup,
                      source: 'puts 9', path: "sum.rb")

    bob = users(:bob)
    submission = Submission.create(task: tasks(:ongoing_sum), user: bob,
                      source: 'puts $stdin.gets.split(" ").map(&:to_i).reduce(:+)', path: "sum.rb")

    assert_equal [bob, sirup], competition.leaderboard
  end

  test "#leaderboard should return user with earliest submission first at tie" do
    competition = competitions(:ongoing)

    bob = users(:bob)
    Submission.create(task: tasks(:ongoing_hello_world), user: bob, 
                      source: 'puts "Hello World"', path: "hello.rb")

    sleep 1

    sirup = users(:sirup)
    Submission.create(task: tasks(:ongoing_hello_world), user: sirup, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [bob, sirup], competition.leaderboard 
  end

  test "#leaderboard does not take new submissions for a past contest into account" do
    competition = competitions(:past)

    bob = users(:bob)
    Submission.create(task: tasks(:past_hello_world), user: bob, 
                      source: 'puts "Hello World"', path: "hello.rb")

    assert_equal [], competition.leaderboard
  end

  test "past contest is visible" do
    assert_equal true, competitions(:past).visible?
  end

  test "ongoing contest is visible" do
    assert_equal true, competitions(:ongoing).visible?
  end

  test "future contest is not visible" do
    refute competitions(:future).visible?
  end

  test "open contest is visible" do
    assert_equal true, competitions(:open).visible?
  end

  test "future? returns true for contest that hasn't started" do
    assert competitions(:future).future?
  end

  test "future? returns false for contest that has started" do
    refute competitions(:ongoing).future?
  end

  test "future? returns false for contest that has expired" do
    refute competitions(:past).future?
  end

  test "future? returns false for an open competition" do
    refute competitions(:open).future?
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
