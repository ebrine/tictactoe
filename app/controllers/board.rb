
class Board
  def initialize(board_string)
    @board_string = board_string
    @board_array = create_array(board_string)
  end

  def create_array(board_string)
    array = board_string.chars
    board_array = []
    board_array << array[0..2]
    board_array << array[3..5]
    board_array << array[6..8]
    board_array
  end

  def return_move
    return 'o        ' if empty_board?
    if imminent_win
      fill_line(imminent_win)
      return @board_string
    else
      fill_random_space
      return @board_string
    end
  end

  def fill_random_space
    corners = [[0,0], [0,2], [2,0], [2,2]]
    corners.each do |i|
      if @board_array[i[0]][i[1]] == ' '
        @board_array[i[0]][i[1]] = 'o'
        @board_string = @board_array.flatten
        return @board_string
      end
    end
    @board_string =  @board_string.sub(' ', "o")
  end

  def empty_board?
    count_chars[2] == 9
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
    return true if diagonal_win?
    return true if horizontal_win?
    return true if vertical_win?
  end

  def imminent_win
    lines = [diagonals, @board_array, columns].flatten.each_slice(3).to_a
    found = []
    lines.each_with_index do |line, line_index|
        if (line.count("o") == 2) && line.count(' ') == 1
          found  = [line_index, line.index(' ')]
          break
        elsif (line.count("x") == 2) && line.count(' ') == 1
          found  = [line_index, line.index(' ')]
          break
        end
    end

    if found != []
      return found
    else
      return false
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
    @board_array[i][j] = "o"
    @board_string = @board_array.flatten
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
    diagonals.each do |diag|
      return true if (diag.count('x') == 3 || diag.count('o') == 3)
    end
    false
  end

  def horizontal_win?
    @board_array.each do |row|
      return true if (row.count('x') == 3 || row.count('o') == 3)
    end
    false
  end

  def vertical_win?
    columns.each do |col|
      return true if (col.count('x') == 3 || col.count('o') == 3)
    end
    false
  end

  def count_chars
    x = @board_string.count("x")
    o = @board_string.count('o')
    space = @board_string.count(" ")
    [x, o, space]
  end

end
