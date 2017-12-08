require_relative 'board'

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

get '/' do
  if params[:board]
    board = Board.new(params[:board])
    if board.winner?
      return board.winner?
    elsif board.valid_board? == false
      status 400
    else
      board.return_move
    end
  else
    return ''
  end
end

get '/winner' do
  if params[:board]
    board = Board.new(params[:board])
    board.winner?
  else
    return ''
  end
end
