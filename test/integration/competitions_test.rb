require 'test_helper'

class CompetitionsIntegrationTest < ActionDispatch::IntegrationTest
  test "show all competitions when signed in" do
    user = sign_in

    within "#content" do
      assert page.has_content?(competitions(:open).name)
      assert page.has_content?(competitions(:time_limited).name)
    end
  end

  test "view a competition" do
    user = sign_in

    within "#content" do
      click_link competitions(:open).name
    end
  end

  test "view a competition's tasks" do
    user = sign_in

    within "#content" do
      click_link competitions(:open).name
    end

    task = competitions(:open).tasks.first

    within "#content" do
      assert page.has_content?(task.name), 
        "Page doesn't have task #{task.name}"
    end
  end

  test "indicate completed task" do
    user = sign_in

    within "#content" do
      click_link competitions(:open).name
    end

    page.assert_no_selector("table tr.success")

    within "#content" do
      click_link tasks(:hello_world).name
    end

    attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
    click_button "Evaluate"

    work_off_jobs

    within "#sidebar" do
      click_link competitions(:open).name
    end

    page.assert_selector("table tr.success")
  end
end
