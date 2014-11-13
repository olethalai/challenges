require File.join(File.dirname(__FILE__), 'models.rb')
require File.join(File.dirname(__FILE__), 'views.rb')

def debug_log(string)
  $DEBUG_MODE ||= false
  print "#{string}\n".blue if $DEBUG_MODE
end

class CountdownController

  def initialize(players=2)
    debug_log "Initializing #{self}"
    @round_controller = RoundController.new(self)
    @player_controller = PlayerController.new(self, players)
    @clock_controller = CountdownClockController.new(self)
  end

  def new_game
    # TODO: Implement game logic
  end

  def get_round_controller
    return @round_controller
  end

  def get_countdown_clock_controller
    return @clock_controller
  end

  def get_player_controller
    return @player_controller
  end

  # Callbacks

  def update_player_score(player_id, score)
    # TODO: Implement score updating
  end

  def show_countdown_clock
    @clock_controller.show_countdown_clock
  end

  def start_countdown_clock
    @clock_controller.start
  end

  def is_clock_active?
    @clock_controller.is_active?
  end

end


class RoundController

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
  end

  def set_round(id)
    @round = id
    case @round
    when 0
      @model = LettersRound.new(self)
    when 1
      @model = NumbersRound.new(self)
    when 2
      @model = CountdownConundrum.new(self)
    end
  end

  def get_round
    return @model.ROUND_ID
  end

  def get_stage
    return @model.stage
  end

  # Callbacks

  def update_player_score(player_id, score)
    # TODO: Implement score updating
  end

  def show_countdown_clock
    @controller.show_countdown_clock
  end

  def start_countdown_clock
    @controller.start_countdown_clock
  end

  def autocomplete_setup
    @model.autocomplete_setup
  end

  def start
    @model.start
  end

  # Delegation...?

  def get_letters_board
    # Must be a letters round
    if @model.class == LettersRound
      return @model.get_letters
    else
      fail "Not playing a Letters round"
    end
  end

  def choose_consonant
    # Must be a letters round
    if @model.class == LettersRound
      @model.choose_consonant
    else
      fail "Not playing a Letters round"
    end
  end

  def choose_vowel
    # Must be a letters round
    if @model.class == LettersRound
      @model.choose_vowel
    else
      fail "Not playing a Letters round"
    end
  end

  def guess_word(word)
    # Must be a letters round
    if @model.class == LettersRound
      @model.guess(word)
    else
      fail "Not playing a Letters round"
    end
  end

  def guess_conundrum(guess)
    # Must be a conundrum round
    if @model.class == CountdownConundrum
    # Player must have buzzed in
    # TODO: Check this is a legit move or refactor
      if @controller.is_clock_active?
        @model.guess(guess)
      else
        fail "No one has buzzed in!"
      end
    else
      fail "Not playing a Conundrum round"
    end
  end

  def set_player_score(score)
    # TODO: Get rid of magic number for player parameter
    @controller.get_player_controller.set_player_score(1, score)
  end

end


class PlayerController

  def initialize(controller, players)
    @controller = controller
    @players = Array.new
    players.times do
      @players.push Player.new(self)
    end
  end

  # Sets the player's score outright
  def set_player_score(player_id, score)
    # TODO: This isn't really an ID system for the players - rename or refactor
    @players[player_id - 1].set_score(score)
  end

  # Callbacks

  def increment_player_score(player_id, points)
    # TODO: Implement score updating
  end

end


class CountdownClockController

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
    @model = CountdownClock.new(self)
    @view = CountdownClockView.new(self)
  end

  def get_countdown_clock
    @model
  end

  def show_countdown_clock
    @view.set_visibility true
  end

  def hide_countdown_clock
    @view.set_visibility false
  end

  def visible?
    return @view.visible?
  end

  def value
    return @model.value
  end

  def start
    @model.start
  end

  def pause
    @model.pause
  end

  def is_active?
    @model.is_active?
  end

end
