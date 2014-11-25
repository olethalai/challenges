Given(/^(\d+) is not a prime number$/) do |n|
  # no-op
end

Given(/^(\d+) is a prime number$/) do |n|
  # no-op
end

When(/^I input (\d+)$/) do |n|
  @response = prime_time(n.to_i)
end

Then(/^I get a true response$/) do
  unless @response
    fail "Response was #{@response}"
  end
end

Then(/^I get a false response$/) do
  if @response
    fail "Response was #{@response}"
  end
end
