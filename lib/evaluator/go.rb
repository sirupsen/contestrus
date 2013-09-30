require 'tempfile'
require_relative "../evaluator"

module Evaluator
  class Go
    def initialize(source)
      @source = source
    end

    def compile
      output = %x(go build -o #{binary_path} #{tmp_file} 2>&1)
      return output if $?.exitstatus != 0
      true
    end

    def command(stdin: "")
      tmp = Tempfile.new("stdin")
      tmp.write stdin
      tmp.flush

      "#{binary_path} < #{tmp.path} 2>&1"
    end

    def run(**options)
      %x(#{command(**options)})
    end
    
    def clean
      File.delete(tmp_file)
      File.delete(binary_path)
    rescue Errno::ENOENT
    end

    private
    def binary_path
      "#{tmp_file}.binary"
    end

    def tmp_file
      return @path if @path

      file = Tempfile.new(["contestrus", ".go"])
      file.write @source
      file.flush

      @path = file.path
    end
  end
end
