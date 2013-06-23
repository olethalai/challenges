# push_steps.rb

# \S denotes any character except whitespace
Given(/^I am sending a notification to (\S*?)$/) do |device|
	# This could eventually take multiple device names
	# This step should add the given device to an array, not set the device, to enable support for multiple devices
	add_device(device.to_sym)
end

Given(/^I specify a (badge) of (.*?)$/) do |option, value|
	set_option(option, value)
end

When(/^I send the command$/) do
	send_command
end

Then(/^the (badge) is set to (.*?) in the(?: notification)? payload$/) do |option, value|
	option_key = get_key(option)
	assert_matching_output("#{option_key}=>#{value}", all_output)
end

Given(/^I do not use the (badge) option$/) do |option|
	clear_option(option)
end

Then(/^the (badge) is not set in the notification payload$/) do |option|
	option_key = get_key(option)
	# There may be a requirement for a --cucumber option, which outputs the payload for the notification
	# This could be as a Hash object
	assert_not_matching_output("#{option_key}", all_output)
end

Then(/^an error is raised$/) do
	# Exit code is 0 if everything went ok
	# Exit code is 1 if the process was aborted
	assert_exit_status(1)
end

Given(/^I include the (badge) option in my command$/) do |option|
	# When set_option_default is called, it should set a default valid value for that option's parameter, if it takes one
	set_option_default(option)
end

Given(/^I do not specify a parameter for the (badge) option$/) do |option|
	set_option(option, "")
end

Given(/^I use the short version of the (badge) command$/) do |option|
	# This should set a boolean value to dictate whether the short or long version of the option is used in the command
	use_short_option(option)
end