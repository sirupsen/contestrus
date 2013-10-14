require 'test_helper'

class EvaluationJobTest < ActiveSupport::TestCase
  setup do
    @submission = Submission.new(
      task: tasks(:hello_world),
      user: users(:sirup),
      path: "hello.rb",
      source: "puts 'Hello World'"
    )
  end

  test "create new evaluation" do
    assert_difference "Evaluation.count", +1 do
      @submission.save!
    end
  end

  test "correct code passes hello world task" do
    @submission.save!

    assert latest_evaluation.passed?, "Evaluation didn't pass: #{latest_evaluation.body.inspect}"
  end

  test "incorrect code fails hello world task" do
    @submission.update_attribute :source, "puts 'omg'"
    @submission.save!

    refute latest_evaluation.passed?, "Evaluation must not pass"
  end

  test "handles input from standard input" do
    submission = Submission.create(
      task: tasks(:sum),
      user: users(:sirup),
      source: "puts $stdin.gets.split(' ').map(&:to_i).reduce(:+)",
      path: "hello.rb"
    )

    submission.save!
    assert submission.passed?, "Submission should pass"
  end

  test "roughly honor execution time limit for program" do
    @submission.source = 'loop { }'
    past = Time.now
    @submission.save!

    assert_in_delta @submission.task.restrictions[:time], Time.now - past, 0.5
    assert_equal "timeout", latest_evaluation.body.first[:status]
  end

  test "set duration for program" do
    @submission.save!

    assert latest_test[:duration], "Duration should be set"
  end

  test "run go program" do
    go = <<-EOF
      package main

      import "fmt"

      func main() {
        fmt.Println("Hello World")
      }
    EOF

    @submission.source = go
    @submission.path = "file.go"
    @submission.save!

    assert @submission.passed?, 
      "Evaluation failed: #{latest_evaluation.inspect}"
  end

  test "reports go compilation errors" do
    go = <<-EOF
      package main

      func main() {
        fmt.Println("Hello World")
      }
    EOF

    @submission.source = go
    @submission.path = "file.go"
    @submission.save!

    assert_equal "compilation failure", latest_test[:status]
    assert_match /undefined: fmt/, latest_test[:output]
  end

  test "reports ruby compilation errors" do
    ruby = <<-EOF
      puts 'Hello World
    EOF

    @submission.source = ruby
    @submission.save!

    assert_equal "compilation failure", latest_test[:status]
    assert_match /unterminated string/, latest_test[:output]
  end

  private
  def latest_evaluation
    @submission.evaluations.last
  end

  def latest_test
    latest_evaluation.body.last
  end
end
