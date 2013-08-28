class HumanPlayer
  attr_reader :color, :board, :name

  def initialize(color, name)
    @color = color
    @board = Chessboard.new
    @name = name
  end

  def move
    board.print_board
    #notify player if they are in check
    puts "#{self.name}, you are in check!".center(40) if board.in_check?(self.color)
    get_move #returns this value
  end

  def get_move
    begin
      puts "#{self.name}, what is your move?(e.g. 'D2 D3' or 'S' to save)".center(40)
      input = $stdin.gets.chomp.upcase
      return input if input == 'S'
      move = translate_input(input)
      validate_move(move)
    rescue => error
      puts "Invalid move, try again".center(40)
      retry
    end
    update_board(move)
    move
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

    raise unless [] == output_move.flatten - (0..7).to_a

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

  def update_board(move)
    board.update(move)
  end
end