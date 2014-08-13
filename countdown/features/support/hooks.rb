# Before('@tag', '@another_tag, ~@loop') do |scenario|
# 	# Executes before each scenario matching the given tags
# end

# After('@tag', '@another_tag, ~@loop') do |scenario|
# 	# Executes after each scenario matching the given tags
# end

# AfterStep('@tag', '@another_tag, ~@loop') do |scenario|
# 	# Executes after each step matching the given tags
# end

After do |scenario|
	# Quit Cucumber if the scenario failed
	if scenario.failed?
		Cucumber.wants_to_quit = true
	end
end