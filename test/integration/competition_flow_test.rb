require 'test_helper'

class CompetitionFlowTest < ActionDispatch::IntegrationTest
  teardown do
    Timecop.return
  end

  test "two competitors should see each others results after the competition" do
    task = tasks(:ongoing_hello_world)
    competition = competitions(:ongoing)

    sign_in(users(:sirup))

    click_link task.name
    submit_solution "hello_world.rb"

    sign_out

    sign_in(users(:bob))

    click_link task.name
    submit_solution "hello_world.rb"

    Timecop.travel(competition.end_at + 10.minutes)

    click_link tasks(:ongoing_sum).name
    submit_solution "sum.rb"

    click_link competition.name

    assert_equal "Not attempted", all("td")[2].text
    assert_equal "Passed", all("td")[3].text

    assert_equal "Not attempted", all("td")[6].text
    assert_equal "Passed", all("td")[7].text
  end

  test "waits for future competition and then attends" do
    task = tasks(:future_hello_world)
    competition = competitions(:future)

    sign_in users(:bob)

    assert_no_selector "a", text: task.name

    Timecop.travel competition.start_at

    visit root_path

    click_link task.name
  end

  test "submission after competition has ended doesnt show up on leaderboard" do
    task = tasks(:ongoing_hello_world)
    competition = competitions(:ongoing)

    sign_in users(:bob)

    click_link task.name

    Timecop.travel competition.end_at + 1.second
    submit_solution "hello_world.rb"

    click_link competition.name

    assert_no_selector "td"
  end
end
