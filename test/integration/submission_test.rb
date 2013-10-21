require 'test_helper'

class SubmissionIntegrationTest < ActionDispatch::IntegrationTest
  test "cannot see submission when contest is no longer open" do
    user = sign_in

    within "#sidebar" do
      click_link competitions(:past).tasks.first.name
    end

    within "#content" do
      refute page.has_selector?("input")
    end
  end
end
