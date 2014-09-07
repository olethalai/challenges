Given(/^I am about to begin playing a (Letters round|Numbers round|Countdown Conundrum)$/) do |round|
  set_round round
  assert_equal round, get_round
end

Then(/^I can see the Countdown Clock$/) do
  check_element_visible countdown_clock
end

Then(/^the Countdown Clock shows (\d+) seconds remaining$/) do |seconds|
  clock_seconds_remaining = 30 - countdown_clock.value
  assert_equal seconds, clock_seconds_remaining
end

Given(/^I am playing a (Letters round|Numbers round|Countdown Conundrum)$/) do |round|
  set_round round
  autocomplete_round_setup
  start_round
  assert_equal round, get_round
  # Setup (stage 0) should be complete, and the round should now be in play (stage 1)
  assert_equal 1, get_round_stage
end

When(/^I (?:have been playing|wait) for (\d+) seconds$/) do |seconds|
  sleep seconds
end

When(/^the Countdown Clock stops$/) do
  wait_for_clock_stop
end

Then(/^the round ends$/) do
  stage = get_round_stage
  assert_equal 2, stage
end
