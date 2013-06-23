# \S denotes any character except whitespace
Given(/^I am sending a notification to (\S*?)$/) do |device|
  pending # express the regexp above with the code you wish you had

  # This could eventually take multiple device names
  # This step should add the given device to an array, not set the device, to enable support for multiple devices
end

Given(/^I specify a badge of (.*?)$/) do |badge_number|
  pending # express the regexp above with the code you wish you had
end

When(/^I send the command$/) do
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Then(/^the badge is set to (\d+) in the notification payload$/) do |badge_number|
  pending # express the regexp above with the code you wish you had
end

Given(/^I do not use the (badge) option$/) do |option|
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Then(/^the (badge) is not set in the notification payload$/) do |option|
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Then(/^an error is raised$/) do
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Given(/^I include the (badge) option in my command$/) do |option|
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Given(/^I do not specify a parameter for the (badge) option$/) do |option|
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end

Given(/^I use the short version of the (badge) command$/) do |option|
  pending # express the regexp above with the code you wish you had

  # This will need to be extracted to a more general steps file eventually
end