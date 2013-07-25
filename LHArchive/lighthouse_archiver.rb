require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'fileutils'
require 'colored'
require 'cobravsmongoose'

$DEBUG_MODE = false

def debug_log(log)
	puts "#{log}".blue if $DEBUG_MODE
end

def debug_error(log)
	puts "#{log}".red if $DEBUG_MODE
end

def debug_success(log)
	puts "#{log}".green if $DEBUG_MODE
end

def archive_project(subdomain, project_id, token)

	# Make a directory for this project
	if !File.directory?("Project_#{project_id}")
		FileUtils.mkdir "Project_#{project_id}"
	end

	page_count = nil
	base_uri = "http://#{subdomain}.lighthouseapp.com/projects/#{project_id}/"
	xml_response = nil
	failed_pages = Array.new
	failed_tickets = Array.new

	# Get the index page which lists the tickets in the project
	puts "Beginning page 1...".blue
	open(base_uri + "tickets.xml?limit=100&_token=#{token}") { |response|
		debug_log "response.status = #{response.status.inspect}, [0]type = #{response.status[0].class}"
		status_code = response.status[0]
		if status_code.to_i != 200
			puts "Error retrieving page 1: #{response.status.inspect}".red

			# If the first page fails, there is no way of knowing how many pages need to be processed
			abort
		else
			xml_response = response.read
			data = CobraVsMongoose.xml_to_hash(xml_response)['tickets']

			
			# Get the number of pages needed to be processed from the total_pages tag
			page_count = data['total_pages']['$'].to_i
			debug_log "page_count = #{page_count}, type = #{page_count.class}"

			# Process the first page of results
			# The IDs of failed tickets will be returned in an array, to be retried later
			failed_tickets.concat(process_tickets(data, base_uri, token, project_id))
		end
	}

	# Iterates through the remaining index pages, sending them for processing as they are loaded
	(2..page_count).each do |i|
		debug_log "Beginning page #{i}..."
		debug_log base_uri + "tickets.xml?limit=100&_token=#{token}&page=#{i}"
		open(base_uri + "tickets.xml?limit=100&_token=#{token}&page=#{i}") { |response|
			debug_log "response.status = #{response.status.inspect}"
			status_code = response.status[0]
			if status_code.to_i >= 500
				debug_error "Request for page #{i} failed"
				failed_pages << i
			else
				debug_success "Request for page #{i} successful"
				xml_response = response.read
				data = CobraVsMongoose.xml_to_hash(xml_response)['tickets']

				# The IDs of failed tickets will be returned in an array, to be retried later
				failed_tickets.concat(process_tickets(data, base_uri, token, project_id))
			end
		}
	end

	# Try again with failed pages if appropriate
	if failed_pages.length > 0
		failed_pages.each do |page_number|
			debug_log "Retrying page #{page_number}..."
			debug_log base_uri + "tickets.xml?limit=100&_token=#{token}&page=#{page_number}"
			open(base_uri + "tickets.xml?limit=100&_token=#{token}&page=#{page_number}") { |response|
				debug_log "response.status = #{response.status.inspect}"
				status_code = response.status[0]
				if status_code.to_i >= 500
					puts "Failed to process page #{page_number}".red
				else
					xml_response = response.read
					data = CobraVsMongoose.xml_to_hash(xml_response)['tickets']
					process_tickets(data, base_uri, token, project_id)
				end
			}
		end
	end

	# Try again with failed tickets if appropriate
	if failed_tickets.length > 0
		failed_tickets.each do |ticket_id|
			debug_log "Retrying ticket #{ticket_id}..."
			if process_ticket(ticket_id, base_uri, token, project_id)
				debug_success "Ticket #{ticket_id} processed successfully on attempt 2"
			else
				debug_error "Ticket #{ticket_id} failed to process on attempt 2"
			end
		end
	end


end

def process_ticket(ticket_id, base_uri, token, project_id)

	success = false
	xml_response = nil
	data = nil

	puts "Processing ticket #{ticket_id}..."

	# Get the extended data for this ticket
	ticket_uri = base_uri + "tickets/#{ticket_id}.xml?_token=#{token}"
	debug_log "Getting data from #{ticket_uri}"

	open(ticket_uri) { |response|
		debug_log "response.status = #{response.status.inspect}"
		status_code = response.status[0]

		# Note of a failure due to an internal server error
		if status_code.to_i >= 500
			debug_error "Request for ticket #{ticket_id} failed"
			failed_tickets << ticket_id
		else
			# Parse the response into a hash to be used for processing
			debug_success "Request for ticket #{ticket_id} successful"
			xml_response = response.read
			data = CobraVsMongoose.xml_to_hash(xml_response)
			debug_success "XML parsed successfully"
		end
	}

	# Create a directory to store assets for this ticket in
	if File.directory?("Project_#{project_id}")
		if !File.directory?("Project_#{project_id}/#{ticket_id}")
			FileUtils.mkdir "Project_#{project_id}/#{ticket_id}"
			debug_success "Directory created for ticket #{ticket_id}"
		else
			debug_log "Directory for ticket #{ticket_id} already exists."
		end
	else
		raise "Directory for project #{project_id} does not exist."
	end

	# Store the raw XML in the directory
	File.open("Project_#{project_id}/#{ticket_id}/#{ticket_id}_raw_data.xml", 'w') {|file|
		file.write(xml_response)
	}

	# Check for attachments
	if data['ticket']['attachments'] == nil
		debug_log "Ticket #{ticket_id} had no attachments."
		success = true
	else
		success = process_attachments(data['ticket']['attachments'], token, project_id, ticket_id)
	end
	
	return success

end

def process_tickets(ticket_data, base_uri, token, project_id)

	tickets = ticket_data['ticket']
	failed_tickets = Array.new

	tickets.each do |ticket|
		ticket_id = ticket['number']['$']
		failed_tickets << ticket_id if process_ticket(ticket_id, base_uri, token, project_id) == false
	end

	# Print out the list of failed tickets
	if failed_tickets.length > 0
		debug_log "Ticket IDs which failed XML parsing:"
		failed_tickets.each do |id|
			debug_log "#{id}".red
		end
		debug_log "The processing of these tickets will be retried after all initial processing has completed".red
	end

	return failed_tickets

end

def process_attachment(attachment_url, attachment_code, project_id, ticket_id)

	debug_log "Processing attachment #{attachment_code}..."

	success = false

	begin
		debug_log "attachment_url = #{attachment_url}"

		# Download the file
		attachment_file = open(attachment_url).read
		debug_success "File downloaded successfully"

		# Get the filename from the URL and use it for the file name
		split_url = attachment_url.split('/')
		debug_log "split url = #{split_url.inspect}"
		# Last path component up to the question mark
		attachment_filename = split_url.pop.split('?')[0]

		# Store the file in the directory for this ticket
		File.open("Project_#{project_id}/#{ticket_id}/#{ticket_id}_attachment_#{attachment_filename}", 'w') {|file|
			file.write(attachment_file)
		}

		success = true
	rescue Exception => e
		error = e.message

		# Redirection is forbidden, so retry with the redirect url
		if error.match(/redirection/)
			debug_log "Redirecting..."
			error_strings = error.split
			success = process_attachment(error_strings.pop, attachment_code, project_id, ticket_id)
		else
			debug_error "Exception raised: #{e}".red
		end
	end

	return success
end

def process_attachments(attachments_data, token, project_id, ticket_id)

	success = false

	attachments_data.each do |attachment_data|
		# Sometimes information doesn't come through completely
		if attachment_data[0] != "@type"

			# Get the URL of the attachment
			# When there is more than one attachment, attachment-data[1] is an array of attachments.
			if attachment_data[1].is_a?(Array)
				attachment_data[1].each do |this_attachment|
					attachment_url = this_attachment['url']['$'] + "?_token=#{token}"
					success = process_attachment(attachment_url, this_attachment['code']['$'], project_id, ticket_id)
					if !success
						retries += 1
						break
					end
				end
			else
				attachment_url = attachment_data[1]['url']['$'] + "?_token=#{token}"
				success = process_attachment(attachment_url, attachment_data[1]['code']['$'], project_id, ticket_id)
			end
		end
	end

	return success

end

