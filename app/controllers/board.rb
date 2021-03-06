
class Board
  def initialize(board_string)
    @board_string = board_string
    @board_array = create_array
  end

  def create_array
    @board_string.chars.each_slice(3).to_a
  end

  def return_move
    if imminent_win
      return fill_line(imminent_win)
    else
      return fill_random_space
    end
  end

  def set_cell(row, col)
    @board_array[row][col] = 'o'
  end

  def fill_random_space
    corners = [[0,0], [0,2], [2,0], [2,2]]
    indeces = corners.find { |i| @board_array[i[0]][i[1]] == ' ' }
    if indeces
      set_cell(indeces[0], indeces[1])
      @board_string = @board_array.join()
    else
      @board_string =  @board_string.sub(' ', "o")
    end
  end

  def valid_board?
    return false if @board_string.length != 9
    return false if @board_string.match(/[^xo\s]/)
    return false if valid_o_turn? == false
    return false if game_over?
  end

  def valid_o_turn?
    char_count = count_chars
    return false if char_count[2] == 0
    return false if (char_count[0] - char_count[1]).abs > 1
    return false if (char_count[1] - char_count[0]) > 0
  end

  def game_over?
    return true if diagonal_win? || horizontal_win? || vertical_win?
  end


  def imminent_win
    return find_imminent_win('o') || find_imminent_win('x')
  end

  def find_imminent_win(player)
    lines = [diagonals, @board_array, columns].flatten.each_slice(3).to_a
    found_line = lines.find { |line| (line.count(player) == 2) && line.count(' ') == 1 }
    if found_line
      line_index = lines.index(found_line)
      cell_index = found_line.index(' ')
      [line_index, cell_index]
    else
      false
    end
  end

  def fill_line(directions)
    line_index = directions[0]
    cell_index = directions[1]

    if [2,3,4].include?line_index
      i = line_index - 2
      j = cell_index
    elsif line_index == 0
      i = cell_index
      j = cell_index
    elsif line_index == 1
      if cell_index == 0
        i = 0
        j = 2
      elsif cell_index == 1
        i = 1
        j = 1
      else
        i = 2
        j = 0
      end
    else
      i = cell_index
      j = line_index - 5
    end
    set_cell(i, j)
    @board_string = @board_array.join()
  end

  def diagonals
    d1 = [@board_array[0][0], @board_array[1][1], @board_array[2][2]]
    d2 = [@board_array[0][2], @board_array[1][1],@board_array[2][0]]
    [d1, d2]
  end

  def columns
    [0,1,2].map { |j| [0,1,2].map { |i| @board_array[i][j] } }
  end

  def diagonal_win?
    direction_win?(diagonals)
  end

  def horizontal_win?
    direction_win?(@board_array)
  end

  def vertical_win?
    direction_win?(columns)
  end

  def direction_win?(lines)
    lines.find { |line| line.count('x') == 3 || line.count('o') == 3}
  end

  def o_win?(lines)
    lines.find { |line| line.count('o') == 3}
  end

  def x_win?(lines)
    lines.find { |line| line.count('x') == 3}
  end

  def x_winner?
      x_win?(diagonals) || x_win?(@board_array) || x_win?(columns)
  end

  def o_winner?
    o_win?(diagonals) || o_win?(@board_array) || o_win?(columns)
  end

  def winner?
    return "x" if x_winner?
    return 'o' if o_winner?
    return false
  end

  def count_chars
    [@board_string.count("x"), @board_string.count('o'), @board_string.count(" ")]
  end

end
