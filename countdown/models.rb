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

  def start
    # Tick in one-second increments
    ticker = Thread.new {
      while @value < 30
        tick
      end
    }
  end

  def tick
    sleep 0.5
    @value += 1
    sleep 0.5
  end

end


class CountdownRound

  attr_accessor :stage, :ROUND_ID

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
    @controller.show_countdown_clock
    @stage = 0
  end

  def start
    if @stage == 1
      @controller.start_countdown_clock
    else
      fail "Cannot start round; incorrect stage: #{@stage}"
    end
  end

end


class LettersRound < CountdownRound

  def initialize(controller)
    super
    # TODO: Write initializer
    @ROUND_ID = 0
    @letters = Array.new(9)
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
