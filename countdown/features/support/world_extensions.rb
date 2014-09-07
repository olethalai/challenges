module RoundManager

  def set_round(id)
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    @round_controller.set_round(id)
  end

  def get_round
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    return @round_controller.get_round
  end

  def autocomplete_round_setup(autocomplete=true)
    @round_controller.autocomplete_setup
  end

  def start_round
    @round_controller.start
  end

  def get_round_stage
    @round_controller.get_stage
  end

end

World(RoundManager)


module Assertions

  def check_element_exists(element)
    assert_not_nil element
  end

  def check_element_visible(element)
    assert_equal true, element.visible?
  end

end

World(Assertions)


module ElementManager

  def countdown_clock
    @countdown_clock ||= $GAME_CONTROLLER.get_countdown_clock_controller
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
