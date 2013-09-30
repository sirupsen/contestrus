require_relative 'evaluator/go'
require_relative 'evaluator/ruby'

module Evaluator
  Languages = {
    "ruby" => Evaluator::Ruby,
    "go"   => Evaluator::Go
  }
end
