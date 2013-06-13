
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'PushIt'
  s.version     = '1.0'
  s.date        = '2013-06-08'
  s.summary     = "Sends push notifications from the command line."
  s.description = "Uses Houston (https://github.com/nomad/houston/) to send push notifications to iOS devices."
  s.authors     = ["Oletha Lai"]
  s.email       = 'oletha@gmail.com'
  s.files       = Dir['bin/*']

  s.add_dependency "houston"
  s.add_dependency "colored"

  s.executables << 'pushit'
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end