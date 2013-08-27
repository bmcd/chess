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

  def check?
    #checks for check
  end

  def checkmate?
    #goes through all possible moves and uses check
  end
end