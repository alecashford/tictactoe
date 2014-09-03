require 'json'

get '/' do
  erb :index
end

post '/next_move' do
  current_board = JSON.parse(request.body.read)
  game = Game.new(current_board)
  game.play
end