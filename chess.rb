# encoding: utf-8

require "./chessboard.rb"
require "./chesspieces.rb"
require "./player.rb"

class Chess
  attr_reader :player1, :player2, :board

  def initialize
    @player1 = HumanPlayer.new('W', 'Player 1')
    puts "Player 1, you play the white pieces."
    @player2 = HumanPlayer.new('B', 'Player 2')
    puts "Player 2, you play the black pieces."
    @board = Chessboard.new
  end

  def play
    players = [player1, player2]

    until board.checkmate?(players[0].color)
      move = players[0].move

      board.update(move)
      players[1].update_board(move)

      players.reverse!
    end
    end_game(players[1])
  end

  def end_game(player)
    puts "#{player.name} wins!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
end

Chess.new.play