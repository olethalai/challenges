Given(/^I am about to begin playing a (Letters round|Numbers round|Countdown Conundrum)$/) do |round|
  set_round round
end

Then(/^I can see the Countdown Clock$/) do
  check_element_exists $COUNTDOWN_CLOCK
end

Then(/^the Countdown Clock shows (\d+) seconds remaining$/) do |seconds|
  clock_seconds_remaining = 30 - $COUNTDOWN_CLOCK.value
  assert_equal clock_seconds_remaining, seconds
end

Given(/^I am playing a (Letters round|Numbers round|Countdown Conundrum)$/) do |round|
  set_round round
  autocomplete_round_setup
  start_round
end

When(/^I (?:have been playing|wait) for (\d+) seconds$/) do |seconds|
  sleep seconds
end

When(/^the Countdown Clock stops$/) do
  wait_for_clock_stop
end

Then(/^the round ends$/) do
  stage = get_round_stage
  assert_equal stage, 2
end
