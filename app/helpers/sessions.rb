require 'rest-client'
require 'json'

helpers do

  class Game
    def initialize(board)
      @board = board
      @candidates = {}
    end

    def play
      next_move
      if @candidates.length < 1
        best_guess
      end
      @candidates.each { |k, v| return k if v == @candidates.values.max }
    end

    def next_move
      check_rows(@board)
      check_columns(@board)
      check_diagonals(@board)
    end

    def check_rows(board)
      board.each do |row|
        row_states = row.map { |cell| cell['state']}
        if (row_states - ['X']).length == 1 && (row_states - ['X'])[0] == '?'
          @candidates[row[row_states.index('?')]['id']] = 10
        end
      end
    end

    def check_columns(board)
      check_rows(board.transpose)#.transpose
    end

    def check_diagonals(board)
      diagonals = [[board[0][0], board[1][1], board[2][2]],
                   [board[0][2], board[1][1], board[2][0]]]
      check_rows(diagonals)
    end

    def best_guess
      
    end
  end




  def next_move(board)
    # claims the absolute middle cell, if it's not already taken
    if board[1][1]['state'] == '?'
      board[1][1]['state'] = 'O'
      board
    else
      # candidates = []
      if check_rows(board) == board
        check_rows(board)
        p candidates
      else
        @board
      end
    end
  end

  def check_rows(current_board)
    current_board.each do |row|
      row_states = row.map { |cell| cell['state']}
      if (row_states - ['X']).length == 1 && (row_states - ['X'])[0] == '?'
        row[row_states.index('?')]['state'] = 'O'
        @candidates[row[row_states.index('?')]['id']] = 10
      end
    end
    current_board
  end

  def check_columns(board)
    check_rows(board.transpose).transpose
  end

  def check_diagonals(current_board)

  end

  def best_guess

  end
end
















