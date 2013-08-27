# encoding: utf-8

class Chesspiece
  HORIZONTAL_ARRAY = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  DIAGONAL_ARRAY = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  attr_accessor :color, :board, :name

  def initialize(color, board)
    @color = color
    @board = board
  end

  def lines(coordinates, differentials)
    possible_moves = []

    differentials.each do |dx, dy|
      current = coordinates.dup
      finished = false
      until finished
        current[0] += dx
        current[1] += dy
        if [] != current - (0..7).to_a
          finished = true
        elsif board[current].color == self.color
          finished = true
        elsif board[current].color != ''
          possible_moves << current
          finished = true
        else
          possible_moves << current.dup
        end
      end
    end

    possible_moves
  end
end

class Castle < Chesspiece
  def initialize(color, board)
    super(color, board)
    @name = color == "W" ? "♖" : "♜"
  end

  def possible_moves(coordinates)
    lines(coordinates, HORIZONTAL_ARRAY)
  end
end

class Knight < Chesspiece
  MOVE_ARRAY = [[-2, -1], [-1, -2], [1, 2], [2, 1], [1, -2], [2, -1], [-2, 1], [-1, 2]]

  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "♘" : "♞"
  end


  def possible_moves(coordinates)
    possible_moves = []

    MOVE_ARRAY.each do |dx, dy|
      puts "Coordinates: #{coordinates}"
      new_x = coordinates[0] + dx
      new_y = coordinates[1] + dy

      next unless (0..7).cover?(new_x) && (0..7).cover?(new_y)

      next if board.get_piece([new_x, new_y]).color == self.color

      possible_moves << [new_x, new_y]
    end

    possible_moves
  end
end

class Bishop < Chesspiece
  def initialize(color, board)
    super(color, board)
    @name = color == "W" ? "♗" : "♝"
  end

  def possible_moves(coordinates)
    lines(coordinates, DIAGONAL_ARRAY)
  end

end

class Queen < Chesspiece
  def initialize(color, board)
    super(color, board)
    @name = color == "W" ? "♕" : "♛"
  end

  def possible_moves(coordinates)
    possible_moves = lines(coordinates, HORIZONTAL_ARRAY)
    possible_moves += lines(coordinates, DIAGONAL_ARRAY)
  end

end

class King < Chesspiece
  def initialize(color, board)
    super(color, board)
    @name = color == "W" ? "♔" : "♚"
  end

  def possible_moves(coordinates)
    diffs = HORIZONTAL_ARRAY + DIAGONAL_ARRAY
    moves = []
    diffs.each do |dx, dy|
      new_move = [coordinates[0] + dx, coordinates[1] + dy]
      moves << new_move unless board[new_move].color == self.color
    end
    moves
  end

end

class Pawn < Chesspiece
  def initialize(color, board)
    super(color, board)
    @name = color == "W" ? "♙" : "♟"
  end

  def possible_moves(coordinates)
    if self.color == "W"
      pawn_block_check(coordinates, 1, 1, 'B')
    else
      pawn_block_check(coordinates, -1, 6, 'W')
    end
  end

  def pawn_block_check(coordinates, dy, starting_row, opp_color)
    moves = []

    move = [coordinates[0], coordinates[1] + dy]
    moves << move if board[move].color == ""

    [-1,1].each do |dx|
      new_move = [coordinates[0] + dx, coordinates[1] + dy]
      moves << new_move if board[new_move].color == opp_color
    end

    move = [coordinates[0], coordinates[1] + (dy * 2)]
    if coordinates[1] == starting_row && board[move].color == ""
      moves << move
    end

    moves
  end
end

class NilPiece < Chesspiece
  def initialize
    @color = ''
    @name = ' '
  end

end