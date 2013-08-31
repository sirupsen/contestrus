require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user" do
    assert_difference 'User.count', +1 do
      User.create(valid_params)
    end
  end

  test "validates presence of username" do
    user = User.new(valid_params.merge(username: nil))
    assert_invalid user
  end

  test "validates presence of password" do
    user = User.new(valid_params.merge(password: nil))
    assert_invalid user
  end

  test "validates minimum length of password" do
    user = User.new(valid_params.merge(password: "hakme"))
    assert_invalid user
  end

  private
  def valid_params
    {
      username: "Simon Hørup Eskildsen",
      password: "seekrit"
    }
  end
end
