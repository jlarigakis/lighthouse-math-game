require_relative "player"
def new_game
  get_names if Player.players.empty?
  Player.players.each { |p| p.revive }
  @current_player = Player.players.first
  puts "Starting game."
  show_lives
  game_loop
end

def challenge(player)
  question, answer = generate_question
  print "#{@current_player.name}: "
  puts question
  player_answer = gets.to_i

  if player_answer == answer
    puts "Correct!"
  else
    puts "Wrong! The correct answer is #{answer.to_s}."
    @current_player.kill
    show_lives
  end
end

def generate_question
  x = rand(20)
  y = rand(20)
  question = "What is #{x} + #{y}?"
  answer = x + y
  return question, answer
end

def show_lives
  puts "Lives remaining: "
  Player.players.each do |player|
    puts "  #{player.name}: #{player.lives}"
  end
  puts
end

def toggle_player
  i = Player.players.index(@current_player)
  @current_player = Player.players[i + 1] || Player.players.first
end

def game_over?
  Player.players.one? { |p| p.alive? }
end

def winner
  Player.players.find { |p| p.alive? } if game_over?
end

def get_names
  print "Player 1, what is your name? "
  Player.new(gets.chomp)

  print "Player 2, what is your name? "
  Player.new(gets.chomp)
end

def game_loop
  loop do
    challenge @current_player

    if game_over?
      puts "The game winner is #{winner.name}."
      winner.add_point
      Player.players.each do |p|
        puts "#{p.name} has #{p.points_string}."
      end
      break
    end

    toggle_player
  end

  print "Play again? (y/[n]) "

  return new_game if gets.chomp.downcase == "y"

  winner = Player.players.max_by { |p| p.points }
  puts "#{winner.name} wins the match with #{winner.points_string}."
end

new_game

