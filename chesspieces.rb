class Chesspiece
  attr_accessor :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end
end

class Castle < Chesspiece
  def initialize( color)
    @name = "#{color}C"
  end
end

class Knight < Chesspiece
  MOVE_ARRAY = [[-2, -1], [-1, -2], [1, 2], [2, 1], [1, -2], [2, -1] [-2, 1], [-1, 2]]

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

end

class Queen < Chesspiece

end

class King < Chesspiece

end

class Pawn < Chesspiece

end