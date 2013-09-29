require 'test_helper'

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  test "navigate to a task" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:mega_inversions).name

    assert page.has_content?(tasks(:mega_inversions).name)
    assert page.has_content?("Number of triples")
  end

  test "submit right answer to task and see it passed" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.success")
  end

  test "submit answer and see status pending" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.info")
  end
end
