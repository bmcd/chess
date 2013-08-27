class HumanPlayer
  attr_reader :color, :board

  def intialize(color)
    @color = color
    @board = Chessboard.new
  end

  def move
    board.print_board
    #notify player if they are in check
    board.check?
    get_move #returns this value
  end

  def get_move
    #gets and returns the players move
    #  gets the move
    #  make sure the input is valid
    #  make sure the move is valid
    #  make sure the move is not check
    #  return the move, loop if error
  end

  def validate_move(move)
    input_valid?(move)
    move_valid?(move)
    move_check?(move)
  end

  def input_valid?(move)
    #raise if input is nonsense or out of range
  end

  def move_valid?(move)
    # raise if space is occupied by friendly
  end

  def move_check?(move)
    #raise if board.check?(move)
  end

  def update_board(move)
    board.update(move)
  end
end