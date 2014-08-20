require File.join(File.dirname(__FILE__), 'models.rb')
require File.join(File.dirname(__FILE__), 'views.rb')

def debug_log(string)
  $DEBUG_MODE ||= false
  print "#{string}\n".blue if $DEBUG_MODE
end

class CountdownController

  def initialize(players=2)
    debug_log "Initializing #{self}"
    @round_controller = RoundController.new
    @player_controller = PlayerController.new(players)
    @countdown_clock = CountdownClock.new
    self.new_game
  end

  def new_game
    # TODO: Implement game logic
  end

  def get_round_controller
    return @round_controller
  end

end

class RoundController

  def initialize
    # TODO: Write initializer
  end

  def set_round(id)
    # TODO: Write round setter
  end

  def get_round
    # TODO: Write round getter
  end

end

class PlayerController

  def initialize(players)
    @players = Array.new
    players.times do
      @players.push Player.new      
    end
  end

end