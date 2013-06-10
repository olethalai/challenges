require 'rubygems'
require 'colored'


def fizzbuzz
 for i in 0..30 do
 	if i % 3 == 0 then
 		if i % 5 == 0
 			puts "fizzbuzz"
 		else
 			puts "fizz"
 		end
 	elsif i % 5 == 0
 		puts "buzz"
 	else
 		puts i
 	end
 end
end



fizzbuzz()