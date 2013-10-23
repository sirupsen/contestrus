require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  test "requires correct user_id and session_hash for a user to be logged in" do
    user = users(:sirup)
    session = Session.new(user_id: user.id, session_hash: user.session_hash)
    assert_equal user, session.user
  end

  test "does not log in a user without a session_hash" do
    user = users(:sirup)
    session = Session.new(user_id: user.id)
    assert_equal nil, session.user
  end

  test "does not log in a user with an incorrect session_hash" do
    user = users(:sirup)
    session = Session.new(user_id: user.id, session_hash: "dhglsdufgidsfgsdfgs")
    assert_equal nil, session.user
  end

  test "sets correct user_id and session_hash when logging a user in" do
    user = users(:sirup)
    session_hash = {}
    session = Session.new(session_hash)
    session.user = user
    assert_equal({ user_id: user.id, session_hash: user.session_hash }, session_hash)
  end

  test "deletes user_id and session_hash keys from session when logging a user out" do
    session_hash = { user_id: 123, session_hash: "foobar" }
    session = Session.new(session_hash)
    session.user = nil
    assert_equal({}, session_hash)
  end

  test "logs in a user with correct username/password" do
    session_hash = {}
    session = Session.new(session_hash)

    assert session.login("sirup", "seekrit")

    assert_equal users(:sirup).id, session_hash[:user_id]
  end

  test "doesn't log in a user with correct username but incorrect password" do
    session_hash = {}
    session = Session.new(session_hash)

    assert session.login("sirup", "fart")

    refute session_hash.key?(:user_id)
  end

  test "doesn't log in a user with incorrect username" do
    session_hash = {}
    session = Session.new(session_hash)

    assert session.login("whatever", "nope")

    refute session_hash.key?(:user_id)
  end
end
