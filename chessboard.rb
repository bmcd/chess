class Chessboard
  attr_accessor :board

  def initialize
    create_board
  end

  def create_board
    # make starting board hash
    # use case while iterating to assign pieces
  end

  def update(move)
    #adds the players move to the board
  end

  def undo_move(move)
    #undoes move (hypothetical checking purposes)
  end

  def check?(move=nil)
    update(move) if move

     #checks for check

    undo_move(move) if move
  end

  def checkmate?
    #goes through all possible moves and uses check
  end

  def print_board
    #prints board
  end

  def get_piece_moves(coordinates)
    piece = board[coordinates]
    ['A', '1']

  end

  def get_piece(coordinates)
    board[coordinates]
  end
end