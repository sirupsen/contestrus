class Language
  attr_accessor :name, :extension, :image, :build, :run, :version

  def initialize(name)
    @name = name
  end

  def key
    name.downcase
  end

  def version
    @docker_version ||= `docker run -i -t #{image} #{@version}`
  end

  class << self
    def define(name)
      yield language = Language.new(name)
      languages[language.key] = language
    end

    def [](name)
      languages[name]
    end

    def find_by_extension(extension)
      languages.values.find { |lang| lang.extension == extension }
    end

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
