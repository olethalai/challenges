require 'rubygems'
require 'colored'
require 'commander/import'
require 'devices.rb'

program :name, 'PushIt'
program :version, '1.0'
program :description, 'Sends push notifications to development iOS apps.'

program :help, 'Author', 'Oletha Lai'
program :help_formatter, :compact

default_command :help

command :devices do |c|
	c.syntax = 'pushit devices [options]'
	c.description = 'Prints out the list of available devices to push to.'

	c.example 'Print the list.', 'pushit devices -f "mini"'

	c.option '-f', '--filter STRING', 'Filters printed results by device type.'

	c.action do |options|
		# Check that there is at least 1 device available
		say_error "There are no available devices.".red and abort if @devices.empty?

		# Filter the list if filtering has been requested.
		if options.filter
			filter = options.filter
			filtered_devices = Hash.new
			@devices.each do |device, info|
				if device[:device].match(/#{filter}/)
					filtered_devices[device] = info
				end
			end

			# Check that there was at least 1 result from the filtering
			say_error "No devices matched your filter.".red and abort if @devices.empty?
		end

		# Sends the filtered list to be printed if it exists.
		device_info = filtered_devices ? filtered_devices : @devices

		# Print the list
		device_info.each do |device, info|
			print "#{device}".bold

			# To ensure that the items are in line with each other, the space of 5 tabs (4 spaces each) will be given for the name field and the space of 3 tabs will be given for the device type
			chars = device.to_s.length
			space_to_next_tab = (4 - (chars % 4))
			if space_to_next_tab != 4
				print "\t"
				chars += space_to_next_tab
			end
			while chars % 20 != 0
				print "\t"
				chars += 4
			end

			print "#{info[:device]}".green

			chars = info[:device].length
			space_to_next_tab = (4 - (chars % 4))
			if space_to_next_tab != 4
				print "\t"
				chars += space_to_next_tab
			end
			while chars % 12 != 0
				print "\t"
				chars += 4
			end

			print "#{info[:token]}".blue
			print "\n"
		end
	end
end

command :push do |c|
	c.syntax = 'pushit push DEVICE [options]'
	c.description = 'Push a notification to the given device. Try running --help for options.'

	c.example 'Send the reference name for your device and any additional options.', 'pushit push laipad --web-link -i'

	# The command should send different payloads based on the options specified.

	c.option '-a', '--app STRING', 'Specify the app you want the notification to be sent to. Ensure you have the certificate for the app named <app>.pem in this directory.'

	c.option '-m', '--message STRING', 'The message to appear on the notification.'
	c.option '-b', '--badge NUMBER', 'Sets the app badge when the notification is received.'
	c.option '-s', '--sound STRING', 'Specifies a sound to be played when the notification is received.'
	c.option '-n', '--newsstand', 'Adds content-available to the payload. Newsstand apps only.'
	c.option '-d', '--download NUMBER', 'Sets the issue ID of the issue to be downloaded in the background.'
	
	c.option '-l', '--link STRING', 'Sends a link of the given type. Choose from: web, itunes, appstore, email, page, location, telephone.'
	c.option '-t', '--button STRING', 'Sets the action button on the notification. If no --button option is chosen, View will appear by default. Choose from: install, read, watch, browse, listen, visit.'

	c.option '-e', '--environment ENV', [:production, :development], 'Environment to send push notification (production or development (default))'
	
	c.action do |devices, options|
		# Ensures that a recipient device was specified.
		say_error "Push aborted. One or more device references required.".red and abort if args.empty?

		if options.environment
			@environment = options.environment.downcase.to_sym
			say_error "Invalid environment,'#{@environment}' (should be either :development or :production)" and abort unless [:development, :production].include?(@environment)
		else
			@environment = :development
		end

		@app = options.app if @app# This will be converted to the certificate filename later on.

		@message = options.message
		@badge = options.badge.nil? ? nil : options.badge.to_i
		@sound = options.sound
		@newsstand = options.newsstand ? true : false
		@issue_id = options.download.nil? ? nil : options.download.to_i

		unless @message or @badge or @sound or @newsstand
			@message = ask_editor "Please enter a message."
			say_error "Push aborted. You must include use least one of the message, badge, sound or newsstand options.".red and abort if @message.nil?
		end

		if options.link
			case options.link.downcase
			when 'web'
				@link = 'http://www.google.com/'
			when 'itunes'
				@link = 'itms://itunes.apple.com/gb/album/insomnia-best-faithless/id305775034'
			when 'appstore'
				@link = 'https://itunes.apple.com/us/app/wwdc/id640199958'
			when 'email'
				@link = 'mailto:testuser@pushit.com?subject=Email%20from%20a%20push%20notification%20link!'
			when 'page'
				@link = 'pm-page://local/54637/72/3/0.4746,0.7323,0.1845,0.5763'
			when 'location'
				@link = 'http://maps.apple.com/?q=cupertino'
			when 'telephone'
				@link = 'tel:150' # Free from a T-Mobile phone.
			else
				say_error "Push aborted. Invalid link type.".red and abort
			end
		end

		if options.button
			button_title = options.button.capitalize
			unless button_title == ('Install' or 'Read' or 'Watch' or 'Browse' or 'Listen' or 'Visit')
				say_error "Push aborted. Invalid button title.".red and abort
			end
			@button = "APNSActionButton" + button_title
		end

		@notifications = []
		devices.each do |device|
			notification = Houston::Notification.new({})
			notification.token = @devices[device.to_sym][:token]
			notification.alert = @message if @message
			notification.badge = @badge if @badge
			notification.sound = @sound if @sound
			notification.content-available = @newsstand if @newsstand

			custom_payload = Hash.new

			# TODO: Find out what the actual names are for :issue and :label.
			custom_payload.merge!({:issue => "#{@issue_id}"})
			custom_payload.merge!({:pmps => {:'link-url' => "#{@link}"}}) if @link
			custom_payload.merge!({'alert' => {:body => "#{@message}", :label => "#{@button}"}}) if @button

			notification.custom_data.merge!(custom_payload)

			@notifications << notification
		end

		client = @environment == :production ? Houston::Client.production : Houston::Client.development
		client.certificate = File.read(@app.nil? ? "#{@app}.pem" : "cert.pem")
		# client.passphrase = password("Please enter the password for the #{@app.capitalize} application certificate:", '*')

		begin
			client.push(*notifications)
		rescue => message
			say_error "Exception sending notification: #{message}".red and abort
		end

		say_ok "Push notification send successful!".green
	end
end


