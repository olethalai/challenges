# Lighthouse Archiver

This is a script which will archive tickets from a Lighthouse project, along with any assets associated with that ticket. Using this method will allow you to store all the information about your Lighthouse tickets, including state changes and comments.

This script was written using Ruby 2.0, so I cannot guarantee compatibility with previous Ruby versions.

You will need:

- The name of your Lighthouse subdomain
- Your Lighthouse project ID
- Your Lighthouse API token

## Instructions

If you are using a Windows computer, you may need to [install Ruby](http://rubyinstaller.org).

If you don't already have [the Bundler gem](http://bundler.io), you'll need to install it.

	$ gem install bundler

Download the `Gemfile` and `lighthouse_archiver.rb` files. **Ensure they are both in the directory where you intend your archive to be.**

Open `lighthouse_archiver.rb` in your text editor of choice.

At the bottom of the file, add the following lines:

	subdomain = "your_lighthouse_subdomain"
	project_id = your_lighthouse_project_id
	token = "your_lighthouse_api_token"
	
	archive_project(subdomain, project_id, token)

Replace the placeholders with the appropriate credentials. (see below for an explanation of where to find these)

Save your changes!

In Terminal, `cd` into the directory where the two files are stored and run the following commands:

	$ bundle install
	$ ruby lighthouse_archiver.rb

Then leave the script to run. You should be able to see folders and files being created as the script executes.

Any initially failing downloads will be retried after the first pass of downloads. If the downloads fail a second time, an error will be printed to alert you as to the page(s) of tickets or ticket number(s) which have not been successful.

## Lighthouse Credentials

If you're unsure of the credentials you need to enter for the script, follow the instructions below.

### Subdomain and Project ID

When you visit a page in your Lighthouse project, the URL will look something like this:

	http://companyname.lighthouseapp.com/projects/55667-project-name/

The **subdomain** starts after the `http://` and ends at `.lighthouse`.

The **project ID** is the number between the last two `/` characters.

For the example URL above, I would need to set my variables to:

	subdomain = "companyname"
	project_id = 55667
	
### API token

Lighthouse Support provides instructions for generating an API token for you to use [here](http://help.lighthouseapp.com/kb/api/how-do-i-get-an-api-token).

You should only require read access to your project in the token you use.

The output will be organised in a logical folder hierarchy which is stored in the current directory. The top-level XML list of tickets will be stored in the project directory. Within the project directory will be a directory for each ticket from the project, named with the ticket's identifier. Inside each ticket directory, the full XML history of the ticket will be stored along with any assets which were attached to the ticket.
