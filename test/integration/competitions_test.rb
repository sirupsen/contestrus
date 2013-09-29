require 'test_helper'

class CompetitionsIntegrationTest < ActionDispatch::IntegrationTest
  test "show all competitions when signed in" do
    user = sign_in
    assert page.has_content?(competitions(:open).name)
    assert page.has_content?(competitions(:time_limited).name)
  end

  test "view a competition" do
    user = sign_in
    click_link competitions(:open).name
  end

  test "view a competition's tasks" do
    user = sign_in
    click_link competitions(:open).name

    task = competitions(:open).tasks.first

    assert page.has_content?(task.name), 
      "Page doesn't have task #{task.name}"
  end

  test "indicate completed task with a checkmark" do
    user = sign_in
    click_link competitions(:open).name
    refute page.has_content?("√")

    click_link tasks(:hello_world).name

    attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
    click_button "Evaluate"

    work_off_jobs

    visit competition_path(competitions(:open))
    assert page.has_content?("√"),
      "Competition page doesn't indicate completed task."
  end
end
