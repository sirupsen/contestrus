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

  test "correct code passes hello world task" do
    @submission.save!
    assert @submission.reload.passed?, "Evaluation didn't pass: #{@submission.body.inspect}"
  end

  test "incorrect code fails hello world task" do
    @submission.source = "puts 'omg'"
    @submission.save!

    refute @submission.reload.passed?, "Evaluation must not pass"
  end

  test "groups results by group" do
    submission = Submission.create(
      task: tasks(:sum),
      user: users(:sirup),
      source: "puts $stdin.gets.split(' ').map(&:to_i).reduce(:+)",
      path: "hello.rb"
    )

    submission.reload
    assert_equal(submission.task.groups.map(&:id), submission.body.keys)
  end

  test "handles input from standard input" do
    submission = Submission.create(
      task: tasks(:sum),
      user: users(:sirup),
      source: "puts $stdin.gets.split(' ').map(&:to_i).reduce(:+)",
      path: "hello.rb"
    )

    assert submission.reload.passed?, "Submission should pass"
  end

  test "includes the test case id" do
    @submission.save!

    assert @submission.reload.body.values.flatten.first[:test_case_id]
  end

  test "roughly honor execution time limit for program" do
    @submission.source = 'loop { }'
    past = Time.now
    @submission.save!

    @submission.reload

    assert_in_delta @submission.task.restrictions["time"], Time.now - past, 1.0
    assert_equal "Time limit exceeded", @submission.body.values.flatten.first[:status]
  end

  test "set duration for program" do
    @submission.save!
    assert @submission.reload.body.values.flatten.first[:duration], "Duration should be set"
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

    @submission.reload

    assert @submission.passed?,
      "Evaluation failed: #{@submission.body.inspect}"
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

    @submission.reload

    assert_equal "Build failed", @submission.status
    assert_match(/undefined: fmt/, @submission.body)
  end

  test "reports ruby compilation errors" do
    ruby = <<-EOF
      puts 'Hello World
    EOF

    @submission.source = ruby
    @submission.save!

    @submission.reload

    assert_equal "Build failed", @submission.status
    assert_match(/unterminated string/, @submission.body)
  end

  test "run node program" do
    js = <<-EOS
      console.log("Hello World")
    EOS

    @submission.source = js
    @submission.path = "file.js"
    @submission.save!

    assert_equal true, @submission.reload.reload.passed?
  end

  test "run coffee program" do
    coffee = <<-EOS
      console.log "Hello World"
    EOS

    @submission.source = coffee
    @submission.path = "file.coffee"
    @submission.save!

    assert_equal true, @submission.reload.reload.passed?
  end

  test "run c program" do
    c = <<-EOS
#include<stdio.h>

int main() {
  printf("Hello World\\n");
  return 0;
}
    EOS

    @submission.source = c
    @submission.path = "file.c"
    @submission.save!

    assert_equal true, @submission.reload.passed?
  end

  test "run java program" do
    c = <<-EOS
public class Solution {
  public static void main (String [] args) throws Exception {
    System.out.println("Hello, World!");
  }
}
    EOS

    @submission.source = c
    @submission.path = "Solution.java"
    @submission.save!

    assert_equal true, @submission.reload.passed?
  end

  test "run cpp program" do
    c = <<-EOS
#include<iostream>
using namespace std;

int main() {
  cout << "Hello World" << endl;
  return 0;
}
    EOS

    @submission.source = c
    @submission.path = "file.cpp"
    @submission.save!

    assert_equal true, @submission.reload.passed?
  end
end
