helpers do

  class Game
    def initialize(board)
      @board = board
      @possible_moves = Hash.new(0)
      @winner = ''
    end

    # best_move is the id of the cell that has the highest calculated score. Class Game
    # takes the board as a hash and returns an updated board with the computer's move,
    # as well as the winner, if it exists.
    def play
      get_possible_moves
      best_move = @possible_moves.select { |k, v| k if v == @possible_moves.values.max }.keys[0]
      @board.each do |row|
        row.each do |tile|
          if tile['id'] == best_move
            tile['state'] = 'O'
          end
        end
      end
      check_for_winner([@board, @board.transpose, diagonals])
      {winner: @winner, board: @board}
    end

    private

    # check_set takes an array of all rows, columns, and diagonals and checks for
    # 1-step victories and 1-step defeats; obvious moves. If there are no obvious moves
    # it makes a best_guess.
    def get_possible_moves
      check_set([@board, @board.transpose, diagonals])
      if @possible_moves.length < 1
        best_guess
      end
    end

    # Defines diagonals here.
    def diagonals
      [[@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]]
    end

    def check_set(sets)
      sets.each do |set|
        set.each do |row|
          row_states = row.map { |tile| tile['state']}
          # Instant victories ranked 20, the highest.
          if (row_states - ['O']).length == 1 && (row_states - ['O'])[0] == '?'
            @possible_moves[row[row_states.index('?')]['id']] = 20
          # Instant defeats ranked 10, important but lower priority.
          elsif (row_states - ['X']).length == 1 && (row_states - ['X'])[0] == '?'
            @possible_moves[row[row_states.index('?')]['id']] = 10
          end
        end
      end
    end

    # Claims middle tile if available. Checks and logs all open cells that touch an existing
    # X. Ranks spots higher if two or more Xs both touch the same blank cell, or if one of the blank
    # cells is in a corner. Ids and ranks are pushed as key/value pairs to @possible_moves hash.
    def best_guess
      if @board[1][1]['state'] == '?'
        @possible_moves[@board[1][1]['id']] = 10
      else
        xs_on_board = []
        @board.each_with_index do |row, row_index|
          row.each_with_index do |tile, tile_index|
            if tile['state'] == 'X'
              xs_on_board << find_neighbors(row_index - 1, tile_index - 1)
              xs_on_board << find_neighbors(row_index - 1, tile_index)
              xs_on_board << find_neighbors(row_index - 1, tile_index + 1)
              xs_on_board << find_neighbors(row_index, tile_index - 1)
              xs_on_board << find_neighbors(row_index, tile_index + 1)
              xs_on_board << find_neighbors(row_index + 1, tile_index - 1)
              xs_on_board << find_neighbors(row_index + 1, tile_index)
              xs_on_board << find_neighbors(row_index + 1, tile_index + 1)
            end
          end
        end
        array_of_xs_ids = xs_on_board.compact.select { |x| x['state'] == '?' }.map { |x| x['id'] }
        array_of_xs_ids.each do |x|
          # Hard coded list of corner cells
          if ['A1', 'A3', 'C1', 'C3'].include?(x)
            @possible_moves[x] += 4
          else
            @possible_moves[x] += 2
          end
        end
      end
    end

    # Helper method for best_guess
    def find_neighbors(y, x)
      if y.between?(0, 2) && x.between?(0, 2)
        @board[y][x]
      end
    end

    # Uses similar logic as check_set to test if the board is won, or drawn.
    # 4 letter code for winner is interpreted by the front-end.
    def check_for_winner(sets)
      if @winner.empty? && @possible_moves.length == 0
        @winner = 'DRAW'
      else
        sets.each do |set|
          set.each do |row|
            row_states = row.map { |tile| tile['state']}
            if (row_states - ['O']).length == 0
              @winner = 'COMP'
            elsif (row_states - ['X']).length == 0
              @winner = 'USER'
            end
          end
        end
      end
    end
  end
end