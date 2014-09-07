# Countdown

=begin

TODO:

Essentials
==========
- 30 second timer
- Score persists through rounds
- Round order: LLN LLN LLN LLN LLC

Additions
=========
- Multiplayer options
- Multiplayer scoring
- Meta-scoring - rounds won between players
- Winner stays on (8 round max)
- Cucumber profile setups for debug/clean runs

Letters
=======
- User input to dictate consonants/vowels up to 9 letters
- Letter appearances are weighted according to their frequency of appearance in English
- Scoring
  - One point per letter
  - Only the player with the longest word gets points
  - Invalid words score no points
  - Players in a winning tie all get points
  - 9-letter words score double = 18 points for 9 letter words

Numbers
=======
- User input to dictate large/small numbers up to 6 numbers
  - 0-4 high numbers permitted
  - 2-6 low numbers permitted
  - Numbers available are 25, 50, 75, 100 and 2 of each number from 1-10
- 3-digit number generated for the round
- Scoring
  - 10 points for an exact solution
  - 7 points if you get within 5 of the target number
  - 5 points if you get within 10 of the target number
  - No points awarded if no one gets within 10
  - Only the player with the closest solution gets points
  - Players in a winning tie all get points

Conundrum
=========
- 9-letter anagram generator
- 10 points for the first person to guess correctly
- No points given if no one guesses correctly
- Round ends after an incorrect guess - timer must be interruptable

=end

require File.join(File.dirname(__FILE__), 'controllers.rb')

def main(*args)
  # Start up a new game
  @game = CountdownController.new
  while !@game.end?
    @game.new_game
  end
end

main
