=begin
You are given 8 identical-looking balls.
One is slightly heavier than the others, but you are unable to tell without a set of balance scales.
Determine the fewest number of weighs required to figure out which is the heavier ball...
Even if the heavy ball is not always in the same position in the set.

Then, solve for n balls. Status: Complete!

Extra credit:
Solve for a random ball being a different weight, but you are not told whether it will be heavier 
or lighter than the other balls. Status: Incomplete.

Notepad++ FTW!
JEdit, get it together.
=end


=begin
class			Ball				Object to be created with variable weight
									Initialize with variables:
										w	Weight of this ball		Default = 5
class var		@@id				Holds the value of the ID for the next ball created
inst var		@id					ID number for this ball
inst var		@weight				Weight of this ball
class method	self.defaultWeight	Returns the default weight of a Ball object
class method	self.resetId		Resets the ID counter to 1
									Recommended use: Call before each new set of balls is created
=end
class Ball
	attr_accessor :weight, :id
	@@id = 1
	
	def initialize(w=5)
		@id = @@id
		@weight = w
		@@id += 1
		return true
	end
	
	def self.defaultWeight()
		checkBall = Ball.new
		@@id -= 1
		return checkBall.weight
	end
	
	def self.resetId()
		@@id = 1
	end
end



=begin
method	weigh			Simulates a set of balance scales using the arrays given
param*	leftBowl		Array containing what will be weighed against the contents of the rightBowl array
param*	rightBowl		Array containing what will be weighed against the contents of the leftBowl array
return	"balanced"		String returned if the contents of the arrays are evaluated to be the same weight
		"left heavier"	String returned if the contents of the leftBowl array are evaluated to be heavier
						than the contents of the rightBowl array
		"right heavier"	String returned if the contents of the rightBowl array are evaluated to be heavier
						than the contents of the leftBowl array
=end
def weigh(leftBowl, rightBowl)
	leftWeight = 0
	rightWeight = 0
	
	leftBowl.each do |thisItem|
		leftWeight += thisItem.weight
	end
	rightBowl.each do |thisItem|
		rightWeight += thisItem.weight
	end
	
	if leftWeight == rightWeight
		return "balanced"
	elsif leftWeight > rightWeight
		return "left heavier"
	else
		return "right heavier"
	end
end



=begin
method 	generateBalls	Generates an array of balls according to the given parameters
param*	b				Number of balls to be generated
param	oddBall			(Index + 1) of the ball with the non-default weight		Default = 1
param	alwaysHeavier	Defines which rule the balls should be generated under	Default = true
							true >> the ball which is a different weight will always be heavier
							false >> the ball which is a different weight can be lighter or heavier
						This functionality may be changed in future so that the rule does not need 
						to be specified for each generation.
return	generatedBalls	Array of balls generated
=end
def generateBalls(b, oddBall=1, alwaysHeavier=true)
	generatedBalls = Array.new
	# Reset Ball IDs to 1 so that IDs stay in line with array indices
	Ball.resetId

	for i in 1..b
		if i != oddBall
			generatedBalls.push Ball.new
		else
			if alwaysHeavier == true
				generatedBalls.push Ball.new(Ball.defaultWeight + 1)
			else
				puts "You need to write code for randomly selecting a heavier or lighter weight!"
			end
		end
	end
	
	return generatedBalls
end



=begin
method	solve			Dictates the order of functions needed to successfully solve the given puzzle
param*	ballsArray		Array of Balls to be considered
return	endResult		@id of the Ball which has been identified as the heavy ball
=end
def solve(ballsArray)
	# Test to ensure valid data has been passed in
	if ballsArray.length == 0
		puts "No balls in given array."
		return "ERROR: I don't have any balls! :("
	end
	
	# Check your efficiency by uncommenting the lines below
	# Use with Ruby 1.9
	# estimatedWeighsLeft = (Math.log(ballsArray.length, 3)).ceil
	# Use with Ruby 1.8
	estimatedWeighsLeft = ((Math.log10(ballsArray.length)/Math.log10(3))).ceil
	puts "Estimated number of weighs left to determine heavy ball: #{estimatedWeighsLeft}"
	
	# If there is only one ball left, the heavy ball has beed found!
	if ballsArray.length == 1
		return ballsArray[0].id
	end
	
	# Uncomment the line below to enter the Matrix
	# puts "calling split(#{ballsArray})"
	splitBallsArray = split(ballsArray)
	roundResult = "result not yet defined for this round"
	endResult = nil
	
	roundResult = weigh(splitBallsArray[0], splitBallsArray[1])

	# The next action to be taken is dependent on the outcome of the weigh
	if roundResult == "balanced"
		endResult = solve(splitBallsArray[2])
	elsif roundResult == "left heavier"
		endResult = solve(splitBallsArray[0])
	elsif roundResult == "right heavier"
		endResult = solve(splitBallsArray[1])
	else
		puts "A result was not found, the puzzle could not be solved. :("
		return false
	end
	
	return endResult
end



=begin
method	split		Splits the Balls given in the Array into 2 or 3 sets, using the bin-packing algorithm
param*	ballsArray	Array of Balls to be split
return	splitSets	Array of Arrays of sorted Balls - should never contain more than 3 elements
=end
def split(ballsArray)
	
	ballSetLeft = Array.new
	ballSetRight = Array.new
	ballSetLeftOut = Array.new
	splitSets = Array.new
	
	# Balls in the left and right sets are evenly distributed
	setSize = (ballsArray.length / 3).floor
	# Any leftover balls go into the left out set, as this will not upset the balance on the next weigh
	leftOutSetSize = setSize + (ballsArray.length % 3)
	
	if setSize == 0 # Then ballsArray only contains two elements
		# For this special case, variables will be set manually
		setSize = 1
		leftOutSetSize = 0
	end
	
	ballsArray[0...setSize].each do |ball|
		ballSetLeft.push ball
	end
	
	ballsArray[setSize...(setSize * 2)].each do |ball|
		ballSetRight.push ball
	end
	
	ballsArray[(setSize * 2)...(setSize * 2 + leftOutSetSize)].each do |ball|
		ballSetLeftOut.push ball
	end
	
	# Tests to ensure the arrays are the correct lengths
	if ballSetLeft.length != setSize
		puts "ballSetLeft is incorrect size"
		puts "Actual: #{ballSetLeft.length}"
		puts "Expected: #{setSize}"
		return
	end
	if ballSetRight.length != setSize
		puts "ballSetRight is incorrect size"
		puts "Actual: #{ballSetRight.length}"
		puts "Expected: #{rightSetSize}"
		return
	end
	if ballSetLeftOut.length != leftOutSetSize
		puts "ballSetLeftOut is incorrect size"
		puts "Actual: #{ballSetLeftOut.length}"
		puts "Expected: #{leftOutSetSize}"
		return
	end
	
	
	# weigh() takes Arrays, so even if there is only one item in the left and right Arrays, they must still be added to the Array of Arrays
	splitSets.push(ballSetLeft, ballSetRight, ballSetLeftOut)
	
	if splitSets.length > 3
		puts "split() tried to split your balls into more than three arrays! D:"
		return false
	else
		return splitSets
	end
end


=begin
method	solveAll	Solves all possible puzzles for the given number of balls
param	n			Number of balls to be used in the puzzles	Default = 8
return	boolean		true if all puzzles were successfully solved, false if any one 
					puzzle could not be solved
=end
def solveAll(n=8)
	for i in 1..n
		puts "Solving for #{n} balls, where ball #{i} is heavier..."
		
		# Gives some visibility on outcomes
		if solve(generateBalls(n, i)) == i
			puts "CORRECT!"
		else
			puts "FAILURE!"
			return false
		end
	end
	
	return true
end



=begin
method	solveAllForMultipleN	Solves all possible puzzles for numbers of balls between the minimum
								and maximum values
param*	maxN					Maximum number of balls you want to solve all combinations for
param*	minN					Minimum number of balls you want to solve all combinations for
return	boolean					true if all puzzles were successfully solved, false if any one 
								puzzle could not be solved
=end
def solveAllForMultipleN(maxN, minN=2)
	# Tests to ensure that valid data has been passed in
	if maxN < minN
		puts "Your maximum must be bigger than your minimum!"
		return false
	end
	if minN < 1
		puts "Minimum must be more than 0."
		return false
	end
	
	for i in minN..maxN
		success = solveAll(i)
	end
	
	# Think with Portals
	if success
		puts "THIS WAS A TRIUMPH!"
		return true
	else
		puts "You're a potato... :("
		return false
	end
end



solveAllForMultipleN(100, 4)





