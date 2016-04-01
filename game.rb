require_relative "player"

class Game
  attr_reader :players
  def initialize(players)
    @players = players
    players.each { |p| p.revive }
    @player = players.sample
  end

  def play
    puts "Starting game."
    puts lives_report
    loop do
      challenge
      break if game_over?
      next_player
    end
  end

  def challenge
    question, answer = generate_question
    print "#{@player.name}: "
    puts question
    player_answer = gets.to_i

    if player_answer == answer
      puts "Correct!"
    else
      puts "Wrong! The correct answer is #{answer.to_s}."
      @player.kill
      puts lives_report
    end
  end

  def generate_question
    x = rand(20)
    y = rand(20)
    question = "What is #{x} + #{y}?"
    answer = x + y
    return question, answer
  end

  def lives_report
    output = "Lives remaining: "
    players.each do |p|
      output << "  #{p.name}: #{p.lives}"
    end
    output
  end

  def next_player
    i = players.index(@player)
    @player = players[i + 1] || players.first
  end

  def game_over?
    players.one? { |p| p.alive? }
  end

  def winner
    players.find { |p| p.alive? } if game_over?
  end
end
