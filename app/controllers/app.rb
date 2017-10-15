require_relative 'board'

get '/' do
  board = Board.new(params[:board])

  if board.valid_board? == false
    status 400
  else
    # board.return_move
  end
end
