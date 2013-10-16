# Bowling
# http://programmingpraxis.com/2009/08/11/uncle-bobs-bowling-game-kata/

=begin
	
Tenpin Bowling

- 10 frames
- 10 pins per frame
- 2 attempts to bowl each frame unless the first ball knocks down all pins
- If the first ball knocks down all pins (strike) then the score for that frame is 10 plus the
  number of pins knocked down on the next two bowls
- If all pins are knocked down after both bowls in a frame (spare) then the score for that frame
  is 10 plus the number of pins knocked down on the next bowl
- If one or more pins are still in tact at the end of the frame, the score for that frame is
  equal to the number of pins knocked down during that frame
- Score accumulates throughout the 10 frames
- Frame 10 includes 2 bowls as usual, but if a strike or spare occurs then the pins are reset
  and extra bowls are executed to determine the bonus for the strike or spare

Write a function which calculates the score of a game of Tenpin Bowling.

=end

require 'rubygems'
require 'colored'

# Logging
# Debug logs only appear if $DEBUG_MODE = true
# Error and success logs always appear

$DEBUG_MODE = true

def debug_log(message)

	puts message.blue if $DEBUG_MODE

end

def error_log(message)

	$stderr.puts message.red

end

def success_log(message)

	puts message.green

end


# Game handling

def new_game(players=1)

	@current_frame = 0
	@board = Array.new(players)

end

def new_frame

	debug_log "Creating new frames for round #{@current_frame + 1}"

	@board.length.times do |i|
		@board[i] ||= Array.new
		@board[i].push(Frame.new)
	end

end

def update_scores(first_roll, second_roll)

	# Update the score for the active player!

end

def print_scores

	# Print all the scores!

end

def play_ball(players=1)

	new_game(players)

	while @current_frame <= 10


		new_frame
		debug_log "Starting frame #{@current_frame}."
		@active_player = 1

		@board.each do |player_frames|
			first_roll = nil
			second_roll = nil

			frame = player_frames[@current_frame - 1]
			first_roll = frame.play

			# Don't play a second roll if the first roll was a strike
			if !frame.strike
				second_roll = frame.play

			end
			
			# Unless it is the first frame, there is a chance that a strike or spare occurred on a previous frame
			if @current_frame > 1
				# It is possible that the two most recent frames are still waiting on bonus scores
				# Check the previous frame
				balls_remaining_in_previous_frame = player_frames[@current_frame - 2].remaining_bonus_balls

				# Add the value of the first roll if one or more bonus balls are remaining for the frame
				if balls_remaining_in_previous_frame > 0
					player_frames[@current_frame - 2].add_bonus(first_roll)

				end

				# Add the value of the second roll if there are 2 bonus balls remaining for the frame
				if balls_remaining_in_previous_frame > 1 and second_roll != nil
					player_frames[@current_frame - 2].add_bonus(second_roll)
				end

				# Only check the frame before last if there are more than 2 frames, otherwise the wrong frame will be returned
				if @current_frame > 2
					balls_remaining_in_frame_before_last = player_frames[@current_frame - 3].remaining_bonus_balls

					# Add the value of the first roll if a bonus ball remains for the frame
					# The second frame should only ever have 1 or 0 bonus balls remaining
					if balls_remaining_in_frame_before_last > 0
						player_frames[@current_frame - 3].add_bonus(first_roll)

					end

				end

			end

			update_scores(first_roll, second_roll)
			print_scores
			@active_player += 1

		end

		debug_log "Frame #{@current_frame} complete."
		@current_frame += 1

	end
end


=begin

@method		public		initialize
@method		private		knocked_pins	Returns a random number of pins knocked down from the number of remaining pins.
@method		public		play			Calculates how the next roll plays out and returns the score for that roll.
@method		public		strike?			Returns a boolean value indicating whether a strike has occurred.
@method		public		spare?			Returns a boolean value indicating whether a spare has occurred.
@method		public		add_bonus		@param		int		bonus		Adds the given bonus to the score for the frame.
@method		public		final_score		Returns the final score of the round if score calculation has no more dependencies.
										Returns false otherwise.

=end

class Frame

	attr_accessor :roll, :strike, :spare, :remaining_bonus_balls, :score

	def initialize

		@roll = 0
		@strike = false
		@spare = false
		@remaining_bonus_balls = 0
		@score = nil

	end

	def knocked_pins(pins_remaining=10)

		return rand(pins_remaining + 1)

	end

	def play

		@roll += 1
		roll_score = nil

		if @roll == 1
			debug_log "Rolling ball 1..."
			roll_score = knocked_pins
			@score = roll_score
			strike?

		elsif @roll == 2
			debug_log "Rolling ball 2..."
			roll_score = knocked_pins(10 - @score)
			@score += roll_score
			spare?

		else
			error_log "No balls left to bowl for this frame!"

		end

		return roll_score

	end

	def strike?

		debug_log "Checking for strike..."

		if @score == 10 and @roll == 1
			success_log "Strike!"
			@strike = true
			@remaining_bonus_balls = 2

		else
			debug_log "No strike."

		end

		return @strike

	end

	def spare?

		if @score == 10 and @roll == 2
			success_log "Spare!"
			@spare = true
			@remaining_bonus_balls = 1

		else
			debug_log "No spare."

		end

		return @spare

	end

	def add_bonus(bonus_score)

		if @remaining_bonus_balls > 0
			@score += bonus_score
			@remaining_bonus_balls -= 1
		
		else
			error_log "There are no remaining bonus balls. Bonus score not added."

		end

	end

	def final_score

		if @remaining_bonus_balls == 0
			return @score

		end

		# The final score cannot be determined yet as this frame is still waiting on bonus balls
		return false

	end

	private :knocked_pins

end

play_ball