#TO DO:
#add file saving and retrieving
#make checkerboard background pattern
#add window that allows clicking to choose move



# encoding: utf-8

require "./chessboard.rb"
require "./chesspieces.rb"
require "./player.rb"
require "colorize"
require "yaml"

class Chess
  attr_reader :board, :players

  def initialize
    player1 = HumanPlayer.new('W', 'Player 1')
    puts "Player 1, you play the white pieces."
    player2 = HumanPlayer.new('B', 'Player 2')
    puts "Player 2, you play the black pieces."
    @board = Chessboard.new
    @players = [player1, player2]
  end

  def play
    until board.checkmate?(players[0].color)
      move = players[0].move

      if move == "S"
        save_game
        next
      end

      board.update(move)
      players[1].update_board(move)

      players.reverse!
    end
    end_game(players[1])
  end

  def end_game(player)
    board.print_board
    puts "#{player.name} wins!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  def save_game
    print "Please provide filename (without file extension): "
    filename = $stdin.gets.chomp + ".txt"
    File.open(filename, 'w') do |file|
      file.puts self.to_yaml
    end
  end
end

if ARGV[0]
  p ARGV[0]
  YAML::load_file(ARGV[0]).play
else
  Chess.new.play
end