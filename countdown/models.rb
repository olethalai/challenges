require File.join(File.dirname(__FILE__), 'controllers.rb')

class Player

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
  end

end


class CountdownClock

  attr_accessor :value

  def initialize(controller)
    @controller = controller
    @value = 0
  end

end


class CountdownRound

  attr_accessor :stage, :ROUND_ID

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
    @controller.show_countdown_clock
  end

end


class LettersRound < CountdownRound

  def initialize(controller)
    super
    # TODO: Write initializer
    @ROUND_ID = 0
    @letters = Array.new(9)
    @stage = 0
  end

  def autocomplete_setup
    @letters.length.times do |i|
      @letters[i] = generate_letter
    end
    @stage = 1
  end

  def generate_letter
    return "A"
  end

end


class NumbersRound < CountdownRound

  def initialize(controller)
    super
    @ROUND_ID = 1
    # TODO: Write initializer
  end

end


class CountdownConundrum < CountdownRound

  def initialize(controller)
    super
    @ROUND_ID = 2
    # TODO: Write initializer
  end

end
