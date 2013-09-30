require 'tempfile'
require_relative "../evaluator"

module Evaluator
  class Ruby
    def initialize(source)
      @source = source
    end

    def compile
      parse = %x(ruby -c #{tmp_file} 2>&1).strip
      return true if parse == "Syntax OK"
      parse
    end

    def command(stdin: "")
      tmp = Tempfile.new("stdin")
      tmp.write stdin
      tmp.flush

      "ruby #{tmp_file} 2>&1 < #{tmp.path}"
    end

    def run(**options)
      %x(#{command(**options)})
    end

    def clean
      File.delete(tmp_file)
    rescue Errno::ENOENT
    end

    private
    def tmp_file
      return @path if @path

      file = Tempfile.new(["contestrus", ".rb"])
      file.write @source
      file.flush

      @path = file.path
    end
  end
end
