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

TODO

- Implement frame 10 logic
- Correct cumulative calculation of frame scores (see example buggy output below)

-------------------------------------------------------------------
| 8 1 | 3 1 | 8 / | 2 / | 8 0 | 1 5 |   X | 7 / | 4 4 | 1 5 |
|   9 |   4 |  12 |  18 |   8 |   6 |  17 |  14 |   8 |   6 | 102 |
-------------------------------------------------------------------

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

	@current_frame = 1
	@board = Array.new(players)
	@player_scores = Array.new(players)

	@player_scores.length.times do |i|
		@player_scores[i] = Array.new(10)
		10.times do |j|
			@player_scores[i][j] = Array.new(2)
		end
	end

end

def new_frame

	debug_log "Creating new frames for round #{@current_frame}"

	@board.length.times do |i|
		@board[i] ||= Array.new
		@board[i].push(Frame.new)

	end

end

def update_scores

	# Update the score for the active player!
	# @first_roll and @second_roll are now instance variables, so don't need to be passed in
	# Add the first and second rolls to the active player's score array as an array of 2 roll values

	# Create the arrays for holding the individual roll scores if it does not already exist
	@player_scores[@active_player - 1] ||= Array.new(10)
	@player_scores[@active_player - 1][@current_frame - 1] ||= Array.new(2)

	# Update the scores to include this frame's rolls
	@player_scores[@active_player - 1][@current_frame - 1][0] = @first_roll
	@player_scores[@active_player - 1][@current_frame - 1][1] = @second_roll

end

def line_break

	return "---------------------------------------------------------------------\n"

end

def roll_score_out(first_roll, second_roll, frame_count, player_index)

	# debug_log "Printing roll scores for frame #{frame_count}..."

	if frame_count == 1
		print line_break

	end

	print "| "

	if first_roll == 10
		# Strike!
		first_roll = " "
		second_roll = "X"

	elsif first_roll + second_roll == 10
		# Spare!
		second_roll = "/"

	end

	if frame_count == 10 and second_roll == "X"
		print "#{second_roll} "

	else
		print "#{first_roll} #{second_roll} "

	end

	# Print any bonuses or additional whitespace if the player has completed frame 10
	if frame_count == 10 and first_roll != "  " and second_roll != "  "
		frame_ten = @board[player_index][frame_count - 1]
		frame_ten_bonuses_out(frame_ten.first_frame_ten_bonus, frame_ten.second_frame_ten_bonus, player_index)

	end

end

def frame_ten_bonuses_out(bonus_1, bonus_2, player_index)
	if @current_frame == 10

		if bonus_1
			if bonus_1 == 10
				bonus_1 = "X"

			elsif !bonus_2
				# No-op
				# Prevents conversion errors if bonus_2 is not an integer for the following conditionals
			
			elsif bonus_1 + bonus_2 == 10
				bonus_2 = "/"

			end

			if bonus_2 == 10
					bonus_2 = "X"

			end
			print "#{bonus_1} "

			if bonus_2
				print "#{bonus_2} "

			end

		else
			print "  "

		end

		print "|     |"

	else
		error_log "It's not frame ten, cannot print frame 10 bonuses."

	end

end


def frame_score_out(frame_score, frame_count)

	# debug_log " Printing frame scores for frame #{frame_count}..."

	# Frame scores should line up with the roll scores
	if frame_count == 1
		print "\n"

	end

	print "| "

	# Frame scores will be right aligned and will never be more than 3 digits long
	if frame_score.class.to_s == "String"
		frame_score = 1000

	end

	if frame_score < 10
		print " "

	end

	if frame_score < 100
		print " "

	end

	# A frame score of 1000 represents a frame which has not yet come to pass
	if frame_score == 1000
		print "    "

	else
		print "#{frame_score} "

	end

	if frame_count == 10
		print "  |"

	end

end

def total_score_out(total_score)

	if total_score < 10
		print " "

	end

	if total_score < 100
		print " "

	end

	print " #{total_score} |\n"

end

def print_scores

	debug_log "Printing scores..."

	# For each player...
	player_index = 0
	@player_scores.each do |game_scores|
		break if game_scores.nil?
		# Print the player's scores from the @player_scores array
		frame_count = 1
		game_scores.each do |round_scores|
			if !round_scores[0].nil?
				player_index = @player_scores.index(game_scores)
				roll_score_out(round_scores[0], round_scores[1], frame_count, player_index)

				if frame_count == 10
					# Print bonus scores for frame 10
					
					game_scores.index

				end

				frame_count += 1

			end

		end

		# Fill in the output for rolls which have not yet come to pass
		while frame_count < 10
			roll_score_out(" ", " ", frame_count, player_index)
			frame_count += 1

		end

		# Prints the frame ten and total placeholders
		# If frame 10 has scores, then spacing will be sorted already and frame_count will be 11
		if frame_count == 10
			roll_score_out("  ", "  ", frame_count, player_index)
			print "|     |"

		end

		# Print the final score of the player's Frames if it's not false
		frame_count = 1
		@board[player_index].each do |frame|
			frame_score = frame.final_score

			# Frame score will be false if the final score has not been determined
			if frame_score
				frame_score_out(frame_score, frame_count)

			else
				break

			end

			frame_count += 1

		end
			
		# Fill in the output for rolls which have not yet come to pass
		while frame_count <= 10
			frame_score_out(" ", frame_count)
			frame_count += 1

		end


		# Calculate the total score for this player
		player_total_score = 0

		@board[player_index].each do |frame|
			final_score = frame.final_score

			# final_score will be false if the final score cannot be determined yet
			if final_score
				player_total_score += final_score

			end

		end

		# Print the total for this player
		total_score_out(player_total_score)

		player_index += 1

	end
	print line_break

end

def distribute_bonus(bonus_count, offset_from_current_frame)

	# Add the value of the second roll if there are 2 bonus balls remaining for the frame
	if bonus_count > 1 and @second_roll != nil
		@board[@active_player - 1][@current_frame - offset_from_current_frame].add_bonus(@second_roll)

	end

	# Add the value of the first roll if one or more bonus balls are remaining for the frame
	if bonus_count > 0
		@board[@active_player - 1][@current_frame - offset_from_current_frame].add_bonus(@first_roll)

	end

end

def play_ball(players=1)

	new_game(players)

	while @current_frame <= 10


		new_frame
		debug_log "Starting frame #{@current_frame}."
		@active_player = 1

		@board.each do |player_frames|
			@first_roll = nil
			@second_roll = nil

			@active_frame = player_frames[@current_frame - 1]
			@first_roll = @active_frame.play

			debug_log "Scored #{@first_roll} on the first go."

			# Don't play a second roll if the first roll was a strike
			if !@active_frame.strike
				@second_roll = @active_frame.play

			debug_log "Scored #{@second_roll} on the second go."

			end
			
			# Unless it is the first frame, there is a chance that a strike or spare occurred on a previous frame
			if @current_frame > 1
				# It is possible that the two most recent frames are still waiting on bonus scores
				# Check the previous frame
				balls_remaining_in_previous_frame = player_frames[@current_frame - 2].remaining_bonus_balls
				
				if balls_remaining_in_previous_frame > 0
					distribute_bonus(balls_remaining_in_previous_frame, 2)
				
				end

				# Only check the frame before last if there are more than 2 frames, otherwise the wrong frame will be returned
				if @current_frame > 2
					balls_remaining_in_frame_before_last = player_frames[@current_frame - 3].remaining_bonus_balls
					
					if balls_remaining_in_frame_before_last > 0
						debug_log "Distributing bonus for frame before last..."
						distribute_bonus(balls_remaining_in_frame_before_last, 3)

					end

				end

			end

			# Frame ten may require additional bonus ball rolls
			if @current_frame == 10

				frame_ten = player_frames[@current_frame - 1]
				debug_log "There are #{frame_ten.remaining_bonus_balls} bonus balls remaining for frame 10."

				# Bowl another ball if frame ten has bonus balls to be accounted for (max of 2 balls)
				if frame_ten.remaining_bonus_balls > 0
					debug_log "Bowling bonus ball 1..."
					# Pins are reset for bonus balls
					frame_ten.first_frame_ten_bonus = frame_ten.knocked_pins
					frame_ten.add_bonus(frame_ten.first_frame_ten_bonus)

					# Bowl another bonus ball if there is one remaining
					if frame_ten.remaining_bonus_balls > 0
						debug_log "Bowling bonus ball 2..."

						# Pins are reset if the last bowl was a strike
						# Strike logic doesn't apply on the frame 10 bonus balls
						if frame_ten.first_frame_ten_bonus == 10
							debug_log "Last bowl was a strike; resetting pins."
							frame_ten.second_frame_ten_bonus = frame_ten.knocked_pins

						else
							frame_ten.second_frame_ten_bonus = frame_ten.knocked_pins(10 - frame_ten.first_frame_ten_bonus)

						end
						
						frame_ten.add_bonus(frame_ten.second_frame_ten_bonus)

					end

				end

			end

			update_scores
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

	attr_accessor :roll, :strike, :spare, :remaining_bonus_balls, :score, :first_frame_ten_bonus, :second_frame_ten_bonus

	def initialize

		@roll = 0
		@strike = false
		@spare = false
		@remaining_bonus_balls = 0
		@score = nil
		@first_frame_ten_bonus = nil
		@second_frame_ten_bonus = nil

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

		debug_log "Bonus balls remaining: #{@remaining_bonus_balls}"

		if @remaining_bonus_balls > 0
			debug_log "Adding #{bonus_score} to score."
			@score += bonus_score
			debug_log "New frame score is #{@score}."
			@remaining_bonus_balls -= 1
			debug_log "There's now #{@remaining_bonus_balls} bonus ball(s) remaining."
		
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

end

play_ball(3)