# Lighthouse Archiver

This is a script which will archive tickets from a Lighthouse project, along with any assets associated with that ticket. Using this method will allow you to store all the information about your Lighthouse tickets, including state changes and comments.

## Instructions

If you are using a Windows computer, you may need to [install Ruby](http://rubyinstaller.org).

If you don't already have [the Bundler gem](http://bundler.io), you'll need to install it.

`$ gem install bundler`

From the directory including the `lighthouse_archiver.rb` file, you will need to install all the other required gems for the script.

`$ bundle install`

After these commands complete, the script should be ready to run, but there are a few more pieces of information you'll need before you can start archiving. These are:

- Your Lighthouse subdomain (String)
- Your Lighthouse project ID (Integer)
- Your Lighthouse API token (String)

You will need to add a method call to `archive_project(subdomain, project_id, api_token)` at the bottom of the script, using the required information.

## Directory Structure

The output will be organised in a logical folder hierarchy which is stored in the current directory. The top-level XML list of tickets will be stored in the project directory. Within the project directory will be a directory for each ticket from the project, named with the ticket's identifier. Inside each ticket directory, the full XML history of the ticket will be stored along with any assets which were attached to the ticket.