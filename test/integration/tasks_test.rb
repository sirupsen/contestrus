require 'test_helper'

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  teardown do
    begin
    BackgroundJob.destroy
    rescue Errno::ENOENT
    end
  end

  test "navigate to a task" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:mega_inversions).name

    assert page.has_content?(tasks(:mega_inversions).name)
    assert page.has_content?("Number of triples")
  end

  test "submit to task and see answer" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    assert page.has_content?("Submitted task"), "Submission notice was not displayed to user"

    work_off_jobs

    visit "/tasks/#{tasks(:hello_world).id}"

    assert page.has_content?("Passed: true")
  end
end
