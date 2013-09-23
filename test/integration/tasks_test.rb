require 'test_helper'

class TasksIntegrationTest < ActionDispatch::IntegrationTest
  test "navigate to a task" do
    user = sign_in
    click_link competitions(:open).name
    click_link tasks(:mega_inversions).name

    assert page.has_content?(tasks(:mega_inversions).name)
    assert page.has_content?("Number of triples")
  end
end
