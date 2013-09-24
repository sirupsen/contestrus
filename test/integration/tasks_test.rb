require 'test_helper'

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  test "navigate to a task" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:mega_inversions).name

    assert page.has_content?(tasks(:mega_inversions).name)
    assert page.has_content?("Number of triples")
  end

  test "submit right answer to task and see checkmark" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    assert page.has_content?("√")
  end

  test "submit right incorrect answer to task and see cross" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello'" 
    click_button "Submit"

    work_off_jobs

    visit task_path(tasks(:hello_world))

    refute page.has_content?("√")
    assert page.has_content?("✘")
  end

  test "submit incorrect and correct answer to task and see cross and checkmark" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello'" 
    click_button "Submit"

    visit task_path(tasks(:hello_world))

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    work_off_jobs
    work_off_jobs

    visit task_path(tasks(:hello_world))

    assert page.has_content?("√"), "Should show check for success submission"
    assert page.has_content?("✘"), "Should show cross for incorrect submission"
  end

  test "submit answer and see evaluation" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:hello_world).name

    fill_in "Source", with: "puts 'Hello'" 
    click_button "Submit"

    visit task_path(tasks(:hello_world))

    fill_in "Source", with: "puts 'Hello World'" 
    click_button "Submit"

    work_off_jobs
    work_off_jobs

    visit task_path(tasks(:hello_world))

    assert page.has_content?("#0: ✘")
    assert page.has_content?("Program: \"Hello\"")

    assert page.has_content?("#0: √")
    assert page.has_content?("Program: \"Hello World")

    assert page.has_content?("Expected: \"Hello World")
  end
end
