require File.join(File.dirname(__FILE__), 'controllers.rb')

class Player

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
  end

end


class CountdownClock

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
  end

end


class CountdownRound

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
  end

end


class NumbersRound < CountdownRound

  def initialize(controller)
    super
    # TODO: Write initializer
  end

end


class CountdownConundrum < CountdownRound

  def initialize(controller)
    super
    # TODO: Write initializer
  end

end
