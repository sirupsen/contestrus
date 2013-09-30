require_relative "../light_test_helper"
require_relative "../../lib/evaluator"

class EvaluatorRubyTest < Minitest::Unit::TestCase
  include Evaluator

  def teardown
    @evaluator.clean
  end

  def test_run_ruby
    program = <<-EOF
      puts "Hello World"
    EOF

    @evaluator = Ruby.new(program)

    assert_equal "Hello World", @evaluator.run.strip
  end

  def test_compile_returns_compilation_error_on_failure
    program = <<-EOF
      puts "Hello World
    EOF

    @evaluator = Ruby.new(program)

    assert_match /unterminated string/, @evaluator.compile
  end

  def test_captures_stderr_when_running
    program = <<-EOF
      $stderr.puts "Hello World" 
    EOF

    @evaluator = Ruby.new(program)

    assert_equal "Hello World", @evaluator.run.strip
  end

  def test_captures_stdin_as_arg_to_run
    program = <<-EOF
      puts $stdin.gets.strip
    EOF

    @evaluator = Ruby.new(program)

    assert_equal "Hello World", @evaluator.run(stdin: "Hello World").strip
  end
end
