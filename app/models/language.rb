class Language
  attr_accessor :name, :extension, :image, :build, :run

  def initialize(name)
    @name = name
  end

  alias_method :key, :name

  class << self
    def define(name)
      yield language = Language.new(name)
      languages[name] = language
    end

    def [](name)
      languages[name]
    end

    def find_by_extension(extension)
      languages.values.find { |lang| lang.extension == extension }
    end

    private
    attr_accessor :languages

    def languages
      @languages ||= {}
    end
  end
end

require_relative "language/ruby"
require_relative "language/cpp"
require_relative "language/c"
require_relative "language/go"
require_relative "language/coffee"
require_relative "language/javascript"
require_relative "language/python"
