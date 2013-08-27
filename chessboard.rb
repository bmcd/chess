# encoding: utf-8

class Chessboard
  attr_accessor :board, :killed_piece

  def initialize
    create_board
  end

  def [](coords)
    board[coords]
  end

  def create_board
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
        8.times do |x|
          board[[x, y]] = make_piece(x, "W")
        end
      when 7
        8.times do |x|
          board[[x, y]] = make_piece(x, "B")
        end
      end
    end
  end

  def make_piece(column, color)
    case column
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
    self.killed_piece = NilPiece.new
    from, to = move

    self.killed_piece = board[to] unless board[to].class == "NilPiece"
    board[to] = board[from]
    board[from] = NilPiece.new
  end

  def undo_move(move)
    #undoes moverequire "chesspieces"
     #(hypothetical checking purposes)
    to, from = move

    board[to] = board[from]
    board[from] = killed_piece
  end

  def in_check?(color, move=nil)
    update(move) if move

    opp_color = (['B', 'W'] - [color]).to_s
    king = color == "W" ? "♔" : "♚"
    check = false

    king_loc = board.select { |location, piece| piece.name == king}.keys[0]

    board.each do |location, piece|
      next unless piece.color == opp_color
      check = true if piece.possible_moves(location).include?(king_loc)
    end

    undo_move(move) if move
    check
  end

  def checkmate?(color)
    #goes through all possible moves and uses check
    false
  end

  def print_board
    #prints board
    header = ("A".."H").map(&:to_s).map { |char| char.ljust(2) }
    y_axis = ("1".."8").map { |char| char.ljust(2) }

    puts "   #{header.join}"

    7.downto(0) do |y|

      row = ["#{y_axis[y]}|"]
      8.times do |x|
        row << board[[x,y]].name
        row << "|"
      end

      row << "#{y_axis[y]}"

      puts row.join
    end

    puts "   #{header.join}"
  end

  def get_piece_moves(coordinates)
    piece = board[coordinates]
    piece.possible_moves(coordinates)
  end

  def get_piece(coordinates)
    board[coordinates]
  end
end