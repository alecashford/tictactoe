require 'rest-client'

helpers do

  class Game
    def initialize(board)
      @board = board
      @possible_moves = Hash.new(0)
      @winner = ''
    end

    def play
      get_possible_moves
      move = @possible_moves.select { |k, v| k if v == @possible_moves.values.max }.keys[0]
      @board.each do |row|
        row.each do |tile|
          if tile['id'] == move
            tile['state'] = 'O'
          end
        end
      end
      check_for_winner([@board, @board.transpose, diagonals])
      {score: @winner, board: @board}
    end

    private

    def get_possible_moves
      check_set([@board, @board.transpose, diagonals])
      if @possible_moves.length < 1
        best_guess
      end
    end

    def diagonals
      [[@board[0][0], @board[1][1], @board[2][2]],
      [@board[0][2], @board[1][1], @board[2][0]]]
    end

    def check_set(sets)
      sets.each do |set|
        set.each do |row|
          row_states = row.map { |tile| tile['state']}
          if (row_states - ['O']).length == 1 && (row_states - ['O'])[0] == '?'
            @possible_moves[row[row_states.index('?')]['id']] = 20
          elsif (row_states - ['X']).length == 1 && (row_states - ['X'])[0] == '?'
            @possible_moves[row[row_states.index('?')]['id']] = 10
          end
        end
      end
    end

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
          if ['A1', 'A3', 'C1', 'C3'].include?(x)
            @possible_moves[x] += 4
          else
            @possible_moves[x] += 2
          end
        end
      end
    end

    def find_neighbors(y, x)
      if y.between?(0, 2) && x.between?(0, 2)
        @board[y][x]
      end
    end

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
  end # class




end