class EvalutatorJob
  def perform(params = {})
  end

  module Language
    class Ruby
      def compile
      end

      def run(program, input)
        `ruby #{program} < #{input}`
      end
    end
  end
end
