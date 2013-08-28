class HumanPlayer
  attr_reader :color, :board, :name

  def initialize(color, name, board)
    @color = color
    @board = board
    @name = name
  end

  def move
    system('clear')
    board.print_board
    if board.in_check?(self.color)
      puts "#{self.name}, you are in check!".center(40)
    end
    get_move
  end

  def get_move
    begin
      puts "#{self.name}, what is your move?".center(40)
      puts "(e.g. 'D2 D3' or 'S' to save)".center(40)
      input = $stdin.gets.chomp.upcase

      return input if input == 'S'
      if input == 'CL'
        raise unless valid_castle?('left')
        return input
      elsif input == 'CR'
        raise unless valid_castle?('right')
        return input
      end
      move = translate_input(input)
      validate_move(move)
    rescue => error
      puts "Invalid move, try again".center(40)
      retry
    end

    move
  end

  def valid_castle?(direction)
    return false if board.in_check?(self.color)


    column = (direction == 'left' ? (0..3).to_a : (5..7).to_a.reverse)
    row = (self.color == "W" ? 0 : 7)
    rook = [column.shift, row]
    king = [4, row]

    column.each do |col|
      move_in_check?([king, [col, row]]) unless col == 1
      return false unless board[[col, row]].color.empty?
    end
    puts 'in valid castle'

    [rook, king].each do |piece|
      board.move_history.each do |turn|
        return false if turn[0] == piece || turn[1] == piece
      end
    end



    true
  end

  def validate_move(move)
    move_valid?(move)
    move_in_check?(move)
  end

  def translate_input(move)
    commands = move.gsub(" ", '').split('')
    raise if commands.length != 4
    from_x, from_y, to_x, to_y = commands

    from_x = letter_to_num(from_x)
    to_x = letter_to_num(to_x)
    from_y = from_y.to_i - 1
    to_y = to_y.to_i - 1

    output_move = [[from_x, from_y], [to_x, to_y]]

    raise unless (output_move.flatten - (0..7).to_a).empty?

    output_move
  end

  def letter_to_num(letter)
    ("A".."H").to_a.index(letter)
  end

  def move_valid?(move)
    from, to = move
    raise unless board[from].color == self.color
    valid_moves = board[from].possible_moves(from)
    raise unless valid_moves.include?(to)
    true
  end

  def move_in_check?(move)
    raise if board.test_for_check(self.color, move)
  end
end