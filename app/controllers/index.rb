require 'json'

get '/' do
  erb :index
end

post '/next_move' do
  current_board = JSON.parse(request.body.read)
  next_move(current_board)
end