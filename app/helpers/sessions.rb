require 'rest-client'

helpers do

  class Game
    def initialize(board)
      @board = board
      @candidates = Hash.new(0)
      @winner = ''
    end

    def play
      next_move
      # if @candidates.length < 1
      #   best_guess
      # end
      @candidates.each { |k, v| return k if v == @candidates.values.max }
    end

    private

    def next_move
      check_rows(@board)
      check_columns(@board)
      check_diagonals(@board)
      best_guess
    end

    def check_rows(board)
      board.each do |row|
        row_states = row.map { |cell| cell['state']}
        if (row_states - ['O']).length == 1 && (row_states - ['O'])[0] == '?'
          @candidates[row[row_states.index('?')]['id']] = 20
        elsif (row_states - ['X']).length == 1 && (row_states - ['X'])[0] == '?'
          @candidates[row[row_states.index('?')]['id']] = 10
        end
      end
    end

    def check_columns(board)
      check_rows(board.transpose)
    end

    def check_diagonals(board)
      diagonals = [[board[0][0], board[1][1], board[2][2]],
                   [board[0][2], board[1][1], board[2][0]]]
      check_rows(diagonals)
    end

    def best_guess
      if @board[1][1]['state'] == '?'
        @candidates[@board[1][1]['id']] = 10
      else
        xs_on_board = []
        @board.each_with_index do |row, row_index|
          row.each_with_index do |cell, cell_index|
            if cell['state'] == 'X'
              xs_on_board << find_neighbors(row_index - 1, cell_index - 1)
              xs_on_board << find_neighbors(row_index - 1, cell_index)
              xs_on_board << find_neighbors(row_index - 1, cell_index + 1)
              xs_on_board << find_neighbors(row_index, cell_index - 1)
              xs_on_board << find_neighbors(row_index, cell_index + 1)
              xs_on_board << find_neighbors(row_index + 1, cell_index - 1)
              xs_on_board << find_neighbors(row_index + 1, cell_index)
              xs_on_board << find_neighbors(row_index + 1, cell_index + 1)
            end
          end
        end
        cleaned_up = xs_on_board.compact.select { |x| x['state'] == '?' }
        array_of_xs_ids = cleaned_up.map { |x| x['id'] }
        array_of_xs_ids.each do |x|
          @candidates[x] += 2
        end
      end
    end

    def find_neighbors(y, x)
      if y.between?(0, 2) && x.between?(0, 2)
        @board[y][x]
      end
    end

  def board_won?
    if !@winner.empty?
      @winner
    end
  end

  end # class




end