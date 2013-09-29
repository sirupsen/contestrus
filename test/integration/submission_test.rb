require 'test_helper'

class SubmissionIntegrationTest < ActionDispatch::IntegrationTest
  test "should navigate to submission and see success" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello World'"
    click_button "Submit"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    click_link "Submission"

    assert page.has_content?("Passed"), "Page should indicate the submission succeeded"
  end

  test "should navigate to submission and see failure" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello'"
    click_button "Submit"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    click_link "Submission"

    assert page.has_content?("Failed"), "Page should indicate the submission succeeded"
  end
end
