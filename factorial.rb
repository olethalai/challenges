# write a recursive function to find the factorial of a number

def factorial(x)
	factorial = 1
	for i in 1..x
		factorial = factorial * i
	end
	puts "#{x}! = #{factorial}"
end


def recursiveFactorial(y)
	if y > 0
		return (y*(recursiveFactorial(y-1)))
	elsif y < 0
		return (y*(recursiveFactorial(y+1)))
	else
		return 1
	end
end

puts recursiveFactorial(-5)