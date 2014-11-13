require File.join(File.dirname(__FILE__), 'controllers.rb')

class Player

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
    @score = 0
  end

  # Sets player's score outright
  def set_score(score)
    @score = score
  end

  def get_score
    return @score
  end

end


class CDLettersPoliceOfficer

  def is_valid_word?(word)
    # if all letters are available on the board
    # and the word is in the dictionary
    return true
  end

end


class CountdownClock

  attr_accessor :value

  def initialize(controller)
    @controller = controller
    @value = 0
    @will_pause = false
    @is_active = false
  end

  def is_active?
    @is_active
  end

  def start
    # Tick in one-second increments
    @will_pause = false
    @is_active = true
    ticker = Thread.new {
      while @value < 30 && !@will_pause
        tick
      end
      @is_active = false
    }
  end

  def tick
    sleep 0.5
    @value += 1
    sleep 0.5
  end

  def pause
    @will_pause = true
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
  # include CDLettersPoliceOfficer

  def initialize(controller)
    super
    # TODO: Write initializer
    @ROUND_ID = 0
    @letters = Array.new
  end

  def get_letters
    return @letters
  end

  def autocomplete_setup
    9.times do |i|
      @letters[i] = generate_letter
    end
    @stage = 1
  end

  def choose_consonant
    @letters.push generate_letter(:consonant)
  end

  def choose_vowel
    @letters.push generate_letter(:vowel)
  end

  def generate_letter(type=:random)
    if type == :random
      if rand(4) == 0
        type = :vowel
      else
        type = :consonant
      end
    end

    case type
    when :consonant
      return "F"
    when :vowel
      return "O"
    else
      fail "Invalid letter type given: #{type}"
    end
  end

  # Returns integer number of points to be given for word
  def guess(word)
    officer = CDLettersPoliceOfficer.new
    points = nil
    if officer.is_valid_word?(word)
      points = word.length
      points = points * 2 if points = 9
    else
      points = 0
    end
    return points
  end

end


class NumbersRound < CountdownRound

  def initialize(controller)
    super
    @ROUND_ID = 1
    # TODO: Write initializer
  end

  def autocomplete_setup
    # TODO: Definitely needs more implementation
    @stage = 1
  end

end


class CountdownConundrum < CountdownRound

  def initialize(controller)
    super
    @ROUND_ID = 2
    @conundrum = "nnnnnnnnn"
    @answer = "nnnnnnnnn"
    # TODO: Write initializer
  end

  def autocomplete_setup
    # TODO: Definitely needs more implementation
    @stage = 1
  end

  def guess(answer)
    if answer == @answer
      @stage = 2
      # TODO: Win/lose logic
    end
  end

end
