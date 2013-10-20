require 'light_test_helper'
require_relative "../../app/models/language"

class LanguageTest < MiniTest::Unit::TestCase
  def test_define_language
    Language.define "ruby" do |language|
      language.extension = "rb"
      language.image = "bouk/ruby"
      language.build = "ruby -c /sandbox/file.rb"
      language.run = "ruby /sandbox/file.rb"
    end

    assert_equal "ruby", Language["ruby"].name
  end

  def test_find_by_extension
    Language.define "ruby" do |language|
      language.extension = "rb"
      language.image = "bouk/ruby"
      language.build = "ruby -c /sandbox/file.rb"
      language.run = "ruby /sandbox/file.rb"
    end

    assert_equal "ruby", Language.find_by_extension("rb").name
  end
end
