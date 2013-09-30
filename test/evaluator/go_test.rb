require_relative "../light_test_helper"
require_relative "../../lib/evaluator"

class GoEvaluator < Minitest::Unit::TestCase
  include Evaluator

  def teardown
    @evaluator.clean
  end

  def test_run_go_program
    program = <<-EOF
      package main

      import (
        "fmt"
      )

      func main() {
        fmt.Println("Hello World")
      }
    EOF

    @evaluator = Go.new(program)

    assert_equal true, @evaluator.compile
    assert_equal "Hello World", @evaluator.run.strip
  end

  def test_returns_compile_errors
    program = <<-EOF
      package main

      func main() {
        fmt.Println("Hello World")
      }
    EOF

    @evaluator = Go.new(program)

    assert_match /undefined: fmt/, @evaluator.compile
  end

  def test_captures_stderr
    program = <<-EOF
      package main

      import (
        "fmt"
        "os"
      )

      func main() {
        fmt.Fprintln(os.Stderr, "Hello World")
      }
    EOF

    @evaluator = Go.new(program)

    assert_equal true, @evaluator.compile
    assert_equal "Hello World", @evaluator.run.strip
  end

  def test_captures_stdin
    program = <<-EOF
      package main

      import (
        "os"
        "io"
        "fmt"
      )

      func main() {
        b := make([]byte, 1024)
        io.ReadFull(os.Stdin, b)
        fmt.Println(string(b))
      }
    EOF

    @evaluator = Go.new(program)

    assert_equal true, @evaluator.compile
    assert_equal "Hello World", @evaluator.run(stdin: "Hello World").strip
  end
end
