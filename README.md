# challenges

A space for keeping all the programming challenges I've attempted. This repository has also been of use to gain some experience with the use of Git.

#### Text Integers

Create a function which outputs integers as text.

#### Meta Noughts And Crosses

Create a playable game of Meta Noughts And Crosses. This would be a great app for iOS 7, with the new zoom-in/zoom-out style of navigation.

* Play a game of noughts and crosses by playing a game of noughts and crosses inside each grid square to gain possession of that square.

* The location of the move played in the last turn maps onto the location of the grid where the next move must be played.

* When the automatically selected grid is full, the player can choose to play wherever they like.

Bonus points for creating AI.

## Completed Challenges

#### Lighthouse Archiving Script - Ruby

Build a script which interacts with the Lighthouse API to download ticket information and any attachments from any given project, and store them in appropriate directories.

This script fulfils a practical purpose - when migrating to another bug tracking tool from Lighthouse, I found that there was not an easy way to download all the data for existing projects. In order to continue to be able to refer back to past tickets, this script can be run to download and store all ticket data before the Lighthouse account is closed.

#### Command Line Interface for APNS - Ruby

Create a function which outputs integers as text.

This challenge served as both educational and practical - as well as learning how to make a tool for the command line and how to make a Ruby gem, it also enabled me to automate push notification testing at work.

#### Heavy Balls - Ruby

*You are given a set of eight balls. Each ball is exactly the same weight as the other, except for one, which is slightly heavier. You have one set of balancing scales. Determine, in the fewest number of weighings, which ball is heavier.*

*Then, solve for n balls where one ball is heavier.*

The first sizable script I wrote using Ruby. This helped me to get to grips with the language to aid in my use of it for Cucumber step definitions.

Were I to do this challenge again, I would add better error handling, as opposed to simply printing descriptions of problems to the console.

#### Command Line Interface for APNS - Ruby

Create a command line interface to enable faster sending of push notifications with specific options enabled to iOS development apps, using [Houston](https://github.com/nomad/houston/).

This challenge serves as both educational and practical - as well as learning how to make a tool for the command line, it will also enable me to automate push notification testing at work.

I encountered some trouble adding data to the payload outside of the built-in `aps` element used by Houston, so there are some bugs to be ironed out here.

#### Lighthouse Archiving Tool - Ruby

Produce a script which downloads project data from Lighthouse and stores it in a logical folder hierarchy on the local machine for archiving.

The Lighthouse API provides XML data for each ticket in a project. The archive should include the XML data for each ticket, (both open and closed) as well as any attachments.

This script was written as part of a migration from Lighthouse to Jira - while we decided not to carry over the project's entire history, we didn't want to lose traceability on all of our past tickets.

Through writing this, I gained valuable experience in handling the reading and writing of files, as well as parsing XML - a useful and flexible skill.

#### Bowling - Ruby

From [Programming Praxis](http://programmingpraxis.com/2009/08/11/uncle-bobs-bowling-game-kata/).

> A game of tenpins bowling lasts ten frames, in each of which the bowler makes one or two attempts to knock down ten pins arranged in a triangle. If the bowler knocks down all ten pins on the first attempt (that’s called a “strike”), he scores ten pins plus the number of pins knocked down on his next two rolls. If the bowler knocks down all ten pins after two attempts (that’s called a “spare”), he scores ten pins plus the number of pins knocked down on his next roll. If the bowler fails to knock down all ten pins (that’s called an “open frame”), he scores the number of pins he knocked down. The scores accumulate through all ten frames. At the last frame, if necessary, the pins are reset for one or two additional rolls to count the final bonus.

> **Your task is to write a function that calculates the score of a tenpins bowling game.**

This challenge turned out to be a lot more complex than I expected, especially with the addition of score printing. I think the most valuable part of this was figuring out which parts should be abstracted into their own functions. Although I know I missed a few opportunities to be more efficient, I think the practice helped me to understand the concept a lot better than I did before.