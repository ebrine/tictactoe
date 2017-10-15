
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
  end

  def empty_board?
    count_chars[2] == 9
  end






  def valid_board?
    puts @board_string
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

  def diagonal_win?
    tl = @board_array[0][0]
    m = @board_array[1][1]
    br = @board_array[2][2]
    tr = @board_array[0][2]
    bl = @board_array[2][0]
    return true if tl == 'x' && m == 'x' && br == 'x'
    return true if tl == 'o' && m == 'o' && br == 'o'
    return true if tr == 'x' && m == 'x' && bl == 'x'
    return true if tr == 'o' && m == 'o' && bl == 'o'
    false
  end

  def horizontal_win?
    @board_array.each do |row|
      return true if (row.count('x') == 3 || row.count('o') == 3)
    end
    false
  end

  def vertical_win?
    [0,1,2].each do |j|
      col = []
      [0,1,2].each do |i|
        col << @board_array[i][j]
      end
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
