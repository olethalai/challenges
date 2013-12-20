# modules.rb

module CommandBuilder

	# Device methods

	def add_device(device)
		@devices ||= Array.new
		@devices << device
		debug_log "Device added: #{device}"
	end

	def add_devices(devices)
		devices.each do |device|
			add_device(device)
		end
	end

	def get_devices
		@devices ||= Array.new
		return @devices
	end

	# Option methods

	def set_option(option, value=true)
		# Default values for keys in the @options Hash will be false
		@options ||= Hash.new(false)
		@options[option] = value
		debug_log "Option set: #{option} => #{value}"
	end

	# Sets a default valid value for the given option
	# The default value will always tend towards the happy path for the given option
	def set_option_default(option)
		value = nil
		case option
		when 'badge'
			value = 1
		else
			raise "Option not supported: #{option_name}"
		end
		debug_log "Setting default for option: #{option}"
		set_option(option, value)
	end

	def clear_option(option)
		@options ||= Hash.new(false)
		@options[option] = false
		debug_log "Option cleared: #{option}"
	end

	def use_short_option(option)
		@short_options ||= Hash.new(false)
		@short_options[option] = true
		debug_log "Short version will now be used for option: #{option}"
	end

	def use_short_option?(option)
		@short_options ||= Hash.new(false)
		return @short_options[option]
	end

	def get_options
		@options ||= Hash.new(false)
		return @options
	end

	def get_key(option)
		key = nil
		case option
		when 'badge'
			key = :badge
		else
			raise "Option not supported: #{option_name}"
		end

		return key
	end

	# Returns the text to be added to the terminal command in order to pass the given option
	def get_option(option_name)
		option = nil
		# Could use ternary conditional expressions here (bool ? true_value : false_value) but chose not to for readability
		if use_short_option?(option_name)
			debug_log "Short version has been flagged for option: #{option}"
			case option_name
			when 'badge'
				option = "-b"
			else
				raise "Option not supported: #{option_name}"
			end
		else
			debug_log "Short version not flagged for option: #{option}. Using long version."
			case option_name
			when 'badge'
				option = "--badge"
			else
				raise "Option not supported: #{option_name}"
			end
		end

		return option

	end


	# Command methods

	def get_primary_command
		@command ||= "push"
		debug_log "Primary command: #{@command}"
		return @command
	end

	def set_primary_command(command)
		@command = command
		debug_log "Primary command set to: #{@command}"
	end

	def build_command
		devices = get_devices
		options = get_options
		primary_command = get_primary_command

		command = "pushit #{primary_command}"
		debug_log "Added primary command #{primary_command} to the command string."

		# Adds device names

		devices.each do |device|
			command << " #{device}"
			debug_log "Added device #{device} to command string."
		end

		# Adds options with associated parameters

		options.each do |option, value|
			# Options which have not been set or which do not require parameters will be false
			if value
				# get_option returns a string containing the long version of the command option
				option_string = get_option(option)
				command << " #{option_string}"
				debug_log "Added option #{option_string} to the command string."
				unless value == !!value # if value is not a boolean...
					command << " #{value}"
					debug_log "Added parameter #{value} for option #{option_string} to the command string."
				end
			end
		end

		debug_log "Command to be run: #{command}"

		return command

	end

	def send_command
		command = build_command
		debug_log "Sending command..."
		run_simple(command, false)
	end

end

World(CommandBuilder)