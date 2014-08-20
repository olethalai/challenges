module RoundManager

  def set_round(id)
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    @round_controller.set_round(id)
  end

  def get_round
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    return @round_controller.get_round
  end

end

World(RoundManager)


module Assertions

  def check_element_exists(element)
    assert_equal true, element.exists?
  end

end

World(Assertions)


module ElementManager

  def countdown_clock
    @countdown_clock ||= $GAME_CONTROLLER.get_countdown_clock
    return @countdown_clock
  end

end

World (ElementManager)

module Debugging

  def debug_log(string)
    print "#{string}\n".blue if $DEBUG_MODE
  end

end

World(Debugging)