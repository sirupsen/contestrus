require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test "create valid language" do
    assert Language.new(valid_language_attributes).valid?
  end

  test "validates presence of name" do
    refute Language.new(valid_language_attributes.merge(name: nil)).valid?
  end

  test "validates presence of extension" do
    refute Language.new(valid_language_attributes.merge(extension: nil)).valid?
  end

  test "validates presence of image" do
    refute Language.new(valid_language_attributes.merge(image: nil)).valid?
  end

  test "validates presence of build" do
    refute Language.new(valid_language_attributes.merge(build: nil)).valid?
  end

  test "validates presence of run" do
    refute Language.new(valid_language_attributes.merge(run: nil)).valid?
  end

  def valid_language_attributes
    languages(:ruby).attributes
  end
end
