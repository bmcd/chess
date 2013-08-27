class Chess
  attr_reader :player1, :player2, :board

  def initialize
    @player1 = HumanPlayer.new('W')
    @player2 = HumanPlayer.new('B')
    @board = Board.new
  end

  def play
    players = [player1, player2]

    until board.checkmate?(move)
      move = players[0].get_move

      board.update(move)
      players[1].update_board(move)

      players.reverse!
    end
    end_game(players[1])
  end
end