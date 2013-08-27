class Chesspiece
  attr_accessor :color, :board, :name

  def initialize(color, board)
    @color = color
    @board = board
  end
end

class Castle < Chesspiece
  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "\u2656" : "\u265C"

  end
end

class Knight < Chesspiece
  MOVE_ARRAY = [[-2, -1], [-1, -2], [1, 2], [2, 1], [1, -2], [2, -1] [-2, 1], [-1, 2]]

  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "\u2658" : "\u265E"
  end


  def possible_move(coordinates)
    possible_moves = []

    MOVE_ARRAY.each do |dx, dy|
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

    @name = color == "W" ? "\u2657" : "\u265D"
  end

end

class Queen < Chesspiece
  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "\u2655" : "\u265B"
  end

end

class King < Chesspiece
  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "\u2654" : "\u265A"
  end

end

class Pawn < Chesspiece
  def initialize(color, board)

    super(color, board)

    @name = color == "W" ? "\u2659" : "\u265F"
  end

end

class NilPiece < Chesspiece
  def initialize
    @color = ''
    @name = ' '
  end

end