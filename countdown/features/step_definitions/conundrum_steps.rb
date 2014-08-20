Given(/^no guesses are made$/) do
  # No-op
end

When(/^I press my buzzer after (\d+) seconds$/) do |seconds|
  sleep seconds
  activate_buzzer
end

When(/^I guess correctly$/) do
  answer = get_conundrum_solution
  guess_conundrum answer
end