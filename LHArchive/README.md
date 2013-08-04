# Lighthouse Archiver

A script to download and save the XML versions of your Lighthouse tickets, along with any attachments, for any given project.

This script was written using Ruby 2.0, so I cannot guarantee compatibility with previous Ruby versions.

You will need:

- The name of your Lighthouse subdomain
- Your Lighthouse project ID
- Your Lighthouse API token

### Instructions

Download the `Gemfile` and `lighthouse_archiver.rb` files. **Ensure they are both in the directory where you intend your archive to be.**

Open `lighthouse_archiver.rb` in your text editor of choice.

At the bottom of the file, add the following lines:

	subdomain = "your_lighthouse_subdomain"
	project_id = "your_lighthouse_project_id"
	token = "your_lighthouse_api_token"
	
	archive_project(subdomain, project_id, token)

Replace the placeholder strings with the appropriate credentials. (see below for an explanation of where to find these)

Save your changes!

In Terminal, `cd` into the directory where the two files are stored and run the following commands:

	$ bundle install

	$ ruby lighthouse_archiver.rb

Then leave the script to run. You should be able to see folders and files being created as the script executes.

Any initially failing downloads will be retried after the first pass of downloads. If the downloads fail a second time, an error will be printed to alert you as to the page(s) of tickets or ticket number(s) which have not been successful.

### Lighthouse Credentials

If you're unsure of the credentials you need to enter for the script, follow the instructions below.

#### Subdomain and Project ID

When you visit a page in your Lighthouse project, the URL will look something like this:

	http://companyname.lighthouseapp.com/projects/55667-project-name/

The **subdomain** starts after the `http://` and ends at `.lighthouse`.

The **project ID** is the number between the last two `/` characters.

For the example URL above, I would need to set my variables to:

	subdomain = "companyname"
	project_id = "55667"
	
#### API token

Lighthouse Support provides instructions for generating an API token for you to use [here](http://help.lighthouseapp.com/kb/api/how-do-i-get-an-api-token).

You should only require read access to your project in the token you use.

