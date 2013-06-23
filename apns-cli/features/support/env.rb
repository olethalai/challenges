# env.rb

require 'aruba/api'

World(Aruba::Api)

$DEBUG_MODE = false

def debug_log(log)
	print("***DEBUG*** " + log) if $DEBUG_MODE
end