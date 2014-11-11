# Snap!

class Player

  @@id = 1

  attr_reader :id

  def initialize
    @id = @@id
    @@id += 1
  end

  def play_next_move
    return random_snap_number
  end

  def random_snap_number
    return rand(10) + 1
  end

end

def play_snap(number_of_players)
  # players = Array.new(number_of_players, Player.new)
  # puts players.inspect
  players = Array.new
  number_of_players.times do
    players.push(Player.new)
  end
  previous_number = 0
  turn = 1
  game_over = false

  while !game_over
    current_player = players[0]
    current_number = current_player.play_next_move

    puts "[Turn #{turn}] Player #{current_player.id} says '#{current_number}'"

    if current_number == previous_number
      # Snap!
      game_over = true
      puts "Player #{current_player.id} says 'Snap!'"
      puts "Player #{current_player.id} wins!"
    end

    players = players.rotate
    previous_number = current_number
    turn += 1
  end
end

play_snap 2
