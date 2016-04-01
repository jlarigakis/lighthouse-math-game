@starting_lives = 3
def challenge(player)
  question, answer = generate_question
  print "#{@names[player]}: "
  puts question
  player_answer = gets.to_i

  if player_answer == answer
    puts "Correct!"
  else
    puts "Wrong! The correct answer is #{answer.to_s}."
    @lives[player] -= 1
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
  @lives.each do |key, p_lives|
    puts " #{@names[key]}: #{p_lives}"
  end
  puts
end

def toggle_player
  @current_player = (@current_player == :player_1) ? :player_2 : :player_1
end

def game_over?
  @lives.has_value? 0
end

def report_winner
  winner = @names.select do |k, name| 
    @lives[k] != 0
  end.values.first if game_over?
  puts "The winner is #{winner}."
end


def new_game
  get_names unless @names
  @lives = { player_1: @starting_lives, player_2: @starting_lives }
  @current_player = :player_1
  puts "Starting game between #{@names[:player_1]} and #{@names[:player_2]}."
  puts "Both players have #{@starting_lives} lives."
  game_loop
end

def get_names
  @names = {}
  print "Player 1, what is your name? "
  @names[:player_1] = gets.chomp

  print "Player 2, what is your name? "
  @names[:player_2] = gets.chomp
end

def game_loop 
  loop do
    challenge @current_player

    if game_over?
      report_winner
      break
    end

    toggle_player
  end
  print "Play again? (y/[n]) "
  new_game if gets.chomp == "y"
end

new_game
