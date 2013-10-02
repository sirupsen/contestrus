require 'test_helper'

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  test "navigate to a task" do
    user = sign_in

    within "#sidebar" do
      click_link tasks(:mega_inversions).name
    end

    assert page.has_content?(tasks(:mega_inversions).name)
    assert page.has_content?("Number of triples")
  end

  test "submit right answer to task and see it passed" do
    user = sign_in
    within "#sidebar" do
      click_link tasks(:hello_world).name
    end

    attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
    click_button "Evaluate"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.success")
  end

  test "submit answer and see status pending" do
    user = sign_in
    within "#sidebar" do
      click_link tasks(:hello_world).name
    end

    attach_file "submission_source", (Rails.root + "test/data/submissions/hello_world.rb").to_s
    click_button "Evaluate"

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.info")
  end
end
