require_relative 'game'
require_relative 'player'

players = []
print "Player 1, what is your name? "
players << Player.new(gets.chomp)

print "Player 2, what is your name? "
players << Player.new(gets.chomp)

loop do
  game = Game.new(players)
  game.play
  puts "#{game.winner.name} wins the game with #{game.winner.lives_string} remaining."
  game.winner.add_point

  print "Play again? (y/[n]) "
  break unless gets.chomp.downcase == "y"
end

winner = players.max_by { |p| p.points }
puts "#{winner.name} wins the match with #{winner.points_string}."
puts
puts players
  .reject { |p| p = winner }
  .each { |p| "#{p.name} has #{p.points_string}." }