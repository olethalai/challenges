=begin
For any circle partially intersected with any square, calculate the gradient of the tangent to the circle which will ensures that the entirety of the circle is on one side of the tangent, while leaving the largest area possible of the square on the opposite side of the tangent.

Area of a circle is Pi r^2.

Coordinates of a point on a circle's circumference (x,y), given the circle's origin (a,b), radius r and the angle t between the x axis and the line which passes through (x,y) and (a,b), can be found using the following equations:
x = a + r cos(t)
y = b + r sin(t)

Intersections of a circle's circumference and a straight line parallel to the y axis (y = n) can be found by solving the quadratic:
n = squareRoot(r^2 - (x - a)^2) + b

=end

class Circle

	attr_accessor :origin_x, :origin_y, :radius

	def initialize()
		@@x_range ||= 10
		@@y_range ||= 10
		@@r_range ||= 4

		@origin_x = rand(@@x_range)
		@origin_y = rand(@@y_range)
		@radius = rand(@@r_range)
	end

	def self.setOriginRange(x, y)
		@@x_range = x
		@@y_range = y
	end

	def self.setRadiusRange(r)
		@@r_range = r
	end
end

class Square

	attr_accessor :origin_x, :origin_y, :sideLength

	def initialize()
		@@x_range ||= 10
		@@y_range ||= 10
		@@s_range ||= 4

		@origin_x = rand(@@x_range)
		@origin_y = rand(@@y_range)
		@sideLength = rand(@@s_range)
	end

	def self.setOriginRange(x, y)
		@@x_range = x
		@@y_range = y
	end

	def self.setRadiusRange(s)
		@@s_range = s
	end
end

def generateCircle(x_range=nil, y_range=nil)
	if x_range != nil && y_range != nil
		Circle.setOriginRange(x_range, y_range)
	end
	@circle = Circle.new()
end

def generateSquare(x_range=nil, y_range=nil)
	if x_range != nil && y_range != nil
		Square.setOriginRange(x_range, y_range)
	end
	@square = Square.new()
end

def generateIntersection(circle, square)
	# Finds an x coordinate of a random point on the circle.
	square_x = (circle.origin_x - circle.radius) + rand(circle.radius * 2)
	# Calculates the part of the equation to find the matching y coordinates which needs to be square rooted.
	y_holder = (circle.radius**2 - (square_x - circle.origin_x)**2)**0.5
	# Ruby automatically takes the non-negative square root so we need to randomly decide whether to take the positive or negative root.
	random = rand(1)
	if random == 0
		square_y = (y_holder * -1) + circle.origin_y
	else
		square_y = y_holder + circle.origin_y
	end

	squareTopRight = [square_x, square_y]
end

def solveRandomIntersection(x_range=nil, y_range=nil, maxRadius=nil)
	generateCircle()
	generateSquare()
	generateIntersection(@circle, @square)
end