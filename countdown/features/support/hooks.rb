Before do |scenario|
  # $BROWSER = Watir::Browser.start $HOME_URL
  $GAME_CONTROLLER = CountdownController.new
end

# After do |scenario|
#   $BROWSER.quit
# end

# AfterStep('@tag', '@another_tag, ~@loop') do |scenario|
#   # Executes after each step matching the given tags
# end

After do |scenario|
  # Quit Cucumber if the scenario failed
  if scenario.failed?
    Cucumber.wants_to_quit = true
  end
end