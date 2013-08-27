class Chessboard
  attr_accessor :board

  def initialize
    create_board
  end

  def create_board
    # make starting board hash
    # use case while iterating to assign pieces
    self.board = Hash.new{ |key, value|  value = NilPiece.new }

    8.times do |y|
      case y
      when 1
        8.times do |x|
          board[[x, y]] = Pawn.new("W", self)
        end
      when 6
        8.times do |x|
          board[[x, y]] = Pawn.new("B", self)
        end
      when 0
        board[[x, y]] = make_piece(x, "W")
      when 7
        board[[x, y]] = make_piece(x, "W")
      end
    end
  end

  def make_piece(col, color)
    case col
    when 0, 7
      return Castle.new(color, self)
    when 1, 6
      return Knight.new(color, self)
    when 2, 5
      return Bishop.new(color, self)
    when 3
      return Queen.new(color, self)
    when 4
      return King.new(color, self)
    end
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