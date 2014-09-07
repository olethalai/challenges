# Transforms

Transform(/(Letters round|Numbers round|Countdown Conundrum)/) do |round|
  id = nil
  case round
  when "Letters round"
    id = 0
  when "Numbers round"
    id = 1
  when "Countdown Conundrum"
    id = 2
  end

  id

end

Transform(/(?:^| )(\d+)(?: |$)/) do |number|
  int = number.to_i

  int
end
