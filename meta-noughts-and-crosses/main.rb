# meta_noughts_and_crosses.rb

require 'rubygems'
require 'colored'

def main

	@game = Grid.new(2)
	@player = "X"

	while !@game.ended? do
		# @player is initially set to X, so O will still start.
		# Switching player at the beginning rather than at the end ensures that the winner is the active player.
		switch_player
		# draw_game(@game)
		puts "Player #{@player}'s move."
		# if !@game.active_grid
		# 	debug_log "active_grid is nil = #{@game.active_grid.nil?}"
		# 	next_grid = nil
		# 	while full?(next_grid)
		# 		next_grid = get_next_move
		# 	end
		# 	@game.set_active_grid(next_grid)
		# end

		# The position of the current move determines the grid that the next move must be made in.
		@game.set_active_grid(@game.move(@player, get_next_move(@game.grid, @game.active_grid)))
	end

end

class Grid

	attr_accessor :grid, :winner, :active_grid, :grid_level

	def initialize(level=2)
		@grid = Array.new(9)
		@winner = nil
		@active_grid = nil
		@grid_level = level

		# Create more grid levels if they were specified
		if level > 1
			@grid.each_index do |i|
				@grid[i] = Grid.new(level - 1)
			end
		end

	end

	def ended?
		return @winner ? true : false
	end

	def set_active_grid(grid_index)
		# grid_index can sometimes be nil.
		debug_log "set_active_grid called with grid_index #{grid_index}"
		@active_grid = grid_index
	end

	def move(player, grid_index)
		set_active_grid(grid_index)
		next_grid = grid_index
		# If this grid is not low enough to play a move on, move to the next grid down.
		if @grid_level > 1
			next_grid = @grid[@active_grid].move(player, get_square(@grid[@active_grid].grid))
		else # This is the lowest level of grid
			@grid[grid_index] = player
		end
		
		# Checks for a win at this level
		if !ended? and check_win(@grid, @grid_level, @player)
			@winner = player
			puts "Player #{player} has won grid #{@active_grid}".green
		end
		
		full_grid = full?(self.grid)

		debug_log "full_grid = #{full_grid}"
		# Returns the next active grid value.
		return full_grid ? nil : next_grid
	end

end

def draw_game(game)

	grid = get_grid_values(game.grid, game.grid_level)

	grid.each do |grid|
		puts grid
	end

end

def get_grid_values(grid_array, level)
	grid = Array.new

	debug_log "grid_array = #{grid_array}"
	debug_log "level = #{level}"

	if level > 1
		grid_array.each do |square|
			grid << get_grid_values(square.grid, level - 1)
		end
	else
		grid << " #{get_grid_value(grid_array[0])} | #{get_grid_value(grid_array[1])} | #{get_grid_value(grid_array[2])} "
		grid << "---|---|---"
		grid << " #{get_grid_value(grid_array[3])} | #{get_grid_value(grid_array[4])} | #{get_grid_value(grid_array[5])} "
		grid << "---|---|---"
		grid << " #{get_grid_value(grid_array[6])} | #{get_grid_value(grid_array[7])} | #{get_grid_value(grid_array[8])} "
	end

	return grid

end

def get_grid_value(token)
	if token
		return token
	else
		return " "
	end
end

def switch_player

	if @player == "O"
		@player = "X"
	elsif @player == "X"
		@player = "O"
	else
		raise "Error: @player was not O or X.".red
	end

end

def get_square(grid)
	index = nil
	while !index
		puts "Which square would you like to play in? Enter a number 1 - 9."
		index = get_index
		if index == false
			# Try again.
		elsif taken?(index, grid)
			puts "That square is not free!".red
			index = nil
		end
	end

	return index
end

def get_next_move(grid, active_grid=nil)
	index = nil
	if active_grid.nil?
		while !index
			puts "Which grid would you like to play in? Enter a number 1 - 9."
			index = get_index
			if index == false
				# Try again.
			elsif full?(grid[index].grid)
				puts "That grid is full!".red
				index = nil
			end
		end
	else
		index = active_grid
	end
	debug_log "index from get_next_move = #{index}"
	return index
end

def get_index
	input = gets.chomp
	int_input = input.to_i
	if int_input < 1 or int_input > 9
		puts "Invalid input, please try again.".red
		return false
	end
	# Convert input to array index.
	return int_input - 1
end

def check_win(grid, grid_level, player)
	# If this grid has already been declared won, don't bother calculating again.
	# if grid.ended?
	# 	return true
	# end

	board = Array.new

	if grid_level > 1
		# Then get the winners of the grid level below and create an array of Xs and Os to check against.
		grid.each do |grid_below|
			board << grid_below.winner
		end
	end

	# Converts the tokens to boolean values to help with the assessment of win criteria.
	# Adds up the number of moves you've played.
	m = 0
	grid.each do |token|
		if token == player
			board << true
			m += 1
		else
			board << false
		end
	end

	# A player cannot win with less than 3 moves.
	if m < 3
		return false
	end
	# 6 moves on one board guarantees a win.
	if m > 6
		return true
	end

	if board[4]
		if board[0]
			if board[8]
				return true
			end
		end
		if board[1]
			if board[7]
				return true
			end
		end
		if board[3]
			if board[5]
				return true
			end
		end
		if board[6]
			if board[2]
				return true
			end
		end
	end
	if board[0]
		if board[1]
			if board[2]
				return true
			end
		end
		if board[3]
			if board[6]
				return true
			end
		end
	end
	if board[8]
		if board[5]
			if board[2]
				return true
			end
		end
		if board[7]
			if board[6]
				return true
			end
		end
	end

	# If execution reaches this far, the board has not been won.
	return false

end

def taken?(index, grid)
	taken = true
	if grid[index] == nil
		taken = false
	end

	return taken
end

def full?(grid)

	return false if !grid

	full_grid = true
	grid.each do |square|
		if square == nil
			full_grid = false
		else
			begin
				if square.winner == nil
					full_grid = false
				end
			rescue
				# No one has won this square yet
			end
		end
		break if !full_grid
	end

	return full_grid

end

def debug_log(log)
	puts log.green if $DEBUG_MODE
end

$DEBUG_MODE = false
main