Gem::Specification.new do |s|
  s.name        = 'PushIt'
  s.version     = '1.0'
  s.date        = '2013-06-08'
  s.summary     = "Sends push notifications from the command line."
  s.description = "Uses Houston (https://github.com/nomad/houston/) to send push notifications to iOS devices."
  s.authors     = ["Oletha Lai"]
  s.email       = 'oletha@gmail.com'
  s.files       = ["lib/pushit.rb"]

  s.add_dependency "houston"
  s.add_dependency "colored"
end