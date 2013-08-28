

# encoding: utf-8

require "./chessboard.rb"
require "./chesspieces.rb"
require "./player.rb"
require "colorize"
require "yaml"

class Chess
  attr_reader :board, :players

  def initialize
    @board = Chessboard.new
    player1 = HumanPlayer.new('W', 'Player 1', board)
    puts "Player 1, you play the white pieces."
    player2 = HumanPlayer.new('B', 'Player 2', board)
    puts "Player 2, you play the black pieces."
    @players = [player1, player2]
  end

  def play
    until checkmate? || stalemate?
      move = players[0].move

      if move == "S"
        save_game
        next
      elsif move == "CL"
        castle('left')
      elsif move == "CR"
        castle('right')
      else
        normal_move(move)
      end

      players.reverse!
    end
  end

  def checkmate?
    result = board.checkmate?(players[0].color)
    if result
      board.print_board
      puts "#{player.name} wins!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    end

    result
  end

  def stalemate?
    result = board.checkmate?(players[0].color, true)
    if result
      board.print_board
      puts "Stalemate!!!!!!!!!!!!1!!!!!!!!1!!!one!!!"
    end

    result
  end

  def normal_move(move)
    board.update(move)
  end

  def castle(direction)
    column = (direction == 'left' ? [0, 3, 4, 2] : [7, 5, 4, 6])
    row = (players[0].color == "W" ? 0 : 7)

    move_one = [[column[0], row], [column[1], row]]
    move_two = [[column[2], row], [column[3], row]]

    board.update(move_one)
    board.update(move_two)
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