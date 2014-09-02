require 'rest-client'
require 'json'

helpers do
  def next_move(current_board)
    # p "helloo"
    # p current_board
    if current_board[1][1]['state'] == '?'
      current_board[1][1]['state'] = 'O'
      current_board.to_json
    else
      current_board.each do |row|
        
      end
      current_board.to_json
    end
  end
end
















