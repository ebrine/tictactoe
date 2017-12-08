require_relative 'board'

get '/' do
  if params[:board]
    board = Board.new(params[:board])
    if board.valid_board? == false
      status 400
    else
      board.return_move
    end
  else
    return ''
  end
end
