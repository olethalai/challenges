module RoundManager

  def round_controller
    @round_controller ||= $GAME_CONTROLLER.get_round_controller
  end

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

# Helper methods which assert and may throw exceptions
module Assertions

  def check_element_exists(element)
    assert_not_nil element
  end

  def check_element_visible(element)
    assert_equal true, element.visible?
  end

end

World(Assertions)

# Helper methods which return booleans
module AssertionHelpers

  def is_vowel?(letter)
    match = letter.match(/^[AEIOU]$/)
    return match.nil? ? false : true
  end

end

World(AssertionHelpers)

module Waiters

  def wait_for_clock_stop
    while countdown_clock.is_active?
      sleep 0.5
    end
  end

end

World(Waiters)

module ElementManager

  def countdown_clock
    @countdown_clock ||= $GAME_CONTROLLER.get_countdown_clock_controller
    return @countdown_clock
  end

  def get_letters_board
    return round_controller.get_letters_board
  end

end

World (ElementManager)


module Debugging

  def debug_log(string)
    print "#{string}\n".blue if $DEBUG_MODE
  end

end

World(Debugging)

module PlayerInterface

  def activate_buzzer
    countdown_clock.pause
  end

  def choose_consonant
    round_controller.choose_consonant
  end

  def choose_vowel
    round_controller.choose_vowel
  end

  def guess_word(word)
    round_controller.guess_word(word)
  end

  def guess_conundrum(guess)
    round_controller.guess_conundrum(guess)
  end

end

World(PlayerInterface)

module PlayerState

  def set_initial_player_score(score)
    @initial_player_score = score
    round_controller.set_player_score(score)
  end

  def get_initial_player_score
    return @initial_player_score
  end

end

World(PlayerState)

# Opposite of PlayerHaters
module PlayerHelpers

  def guess_valid_word(length)
    # TODO: Find a valid word in the current board with the right length
    word = "FOOOFFF"
    # Make the guess
    guess_word(word)
  end

  def guess_invalid_word(length)
    # This is not a real word, so it's always invalid
    word = "ZZZZZZZ"
    guess_word(word)
  end

end

World(PlayerHelpers)

module DictionaryCorner

  def get_conundrum_solution
    "nnnnnnnnn"
  end

end

World(DictionaryCorner)
