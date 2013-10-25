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

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.success")
  end

  test "submit incorrect answer and see status failed" do
    user = sign_in
    within "#sidebar" do
      click_link tasks(:hello_world).name
    end

    attach_file "submission_source", (Rails.root + "test/data/submissions/hello.rb").to_s
    click_button "Evaluate"

    visit task_path(tasks(:hello_world))

    page.assert_selector("tbody > tr.error")
  end

  test "should not see the task of a future competition anywhere" do
    user = sign_in

    within "#sidebar" do
      refute page.has_content?(tasks(:future_hello_world).name), 
        "Should not show task for future contest in sidebar."
    end
  end

  test "should see the tasks of an expired competition" do
    user = sign_in

    click_link "Tasks"

    within "#content" do
      assert page.has_content?(tasks(:past_hello_world).name), 
        "Should see a task of an expired compeition."
    end
  end

  test "should see the tasks of an open competition" do
    user = sign_in

    click_link "Tasks"

    within "#content" do
      assert page.has_content?(tasks(:hello_world).name), 
        "Should see a task of an expired compeition."
    end
  end

  test "should see the tasks of an ongoing competition" do
    user = sign_in

    click_link "Tasks"

    within "#content" do
      assert page.has_content?(tasks(:ongoing_hello_world).name), 
        "Should see a task of an expired compeition."
    end
  end
end
