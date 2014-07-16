require 'test_helper'

class SubmissionIntegrationTest < ActionDispatch::IntegrationTest
  test "submit for ongoing contest and see passed in sidebar" do
    user = sign_in

    within "#sidebar" do
      click_link tasks(:ongoing_hello_world).name
    end

    within "#content" do
      attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
      click_button "Evaluate"
    end

    within "#sidebar" do
      assert_selector ".label-success", text: "Passed"
    end
  end

  test "submit for past contest and see no passed in sidebar" do
    user = sign_in

    within "#sidebar" do
      click_link tasks(:past_hello_world).name
    end

    within "#content" do
      attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
      click_button "Evaluate"
    end

    within "#sidebar" do
      assert_no_selector ".label-success", text: "Passed"
    end
  end

  test "submit for ongoing contest and see pending in sidebar and no points" do
    user = sign_in

    queue_jobs do
      within "#sidebar" do
        click_link tasks(:ongoing_hello_world).name
      end

      within "#content" do
        attach_file "submission_source", Rails.root + "test/data/submissions/hello_world.rb"
        click_button "Evaluate"
      end

      within "#sidebar" do
        assert_selector ".label-info", text: "Pending"
      end
    end
  end

  test "submit with ioi style scoring shows the score" do
    user = sign_in

    within "#sidebar" do
      click_link tasks(:ongoing_ioi_sum).name
    end

    within "#content" do
      attach_file "submission_source", Rails.root + "test/data/submissions/sum.rb"
      click_button "Evaluate"
    end
  end 
end
