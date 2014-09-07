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

  # Callbacks

  def update_player_score(player_id, score)
    # TODO: Implement score updating
  end

  def show_countdown_clock
    @clock_controller.show_countdown_clock
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
    return @round
  end

  # Callbacks

  def update_player_score(player_id, score)
    # TODO: Implement score updating
  end

  def show_countdown_clock
    @controller.show_countdown_clock
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

  # Callbacks

  def update_player_score(player_id, score)
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
    # TODO: Write countdown clock getter
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

end
