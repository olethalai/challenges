module RoundManager

  def set_round(id)
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    @round_controller.set_round(id)
  end

  def get_round
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
    return @round_controller.get_round
  end

  def convert_to_round_id(round_string)
    case round_string.downcase
    when "letters round"
      return 0
    when "numbers round"
      return 1
    when "countdown conundrum"
      return 2
    else
      fail "Attempted to convert invalid round string: #{round_string}"
    end
  end

  def autocomplete_round_setup(autocomplete=true)
    @autocomplete_round_setup = autocomplete
  end

  def start_round
    # TODO: Implement round management
    # Will this manager handle the autocomplete for setup?
  end

  def get_round_stage
    # TODO: Tap into the RoundController to see what stage the round is at
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