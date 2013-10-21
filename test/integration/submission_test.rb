require 'test_helper'

class SubmissionIntegrationTest < ActionDispatch::IntegrationTest
  test "cannot submit when contest is no longer open" do
    user = sign_in

    within "#sidebar" do
      click_link competitions(:past).tasks.first.name
    end

    attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
    click_button "Evaluate"

    within "#content" do
      assert page.has_content?("Competition is no longer open")
    end
  end
end
