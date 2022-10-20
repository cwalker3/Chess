# frozen_string_literal: true

# board class for chess
class Board
  def initialize(board = create_board)
    @board = board
  end

  def create_board
    board = Array.new(8) { Array.new(8) }
    populate_board
  end

  def populate_board
    board.each_index do |row|
      row.each_index do |column|
        board[row][column] << Piece.for([row, column])
      end
    end
  end

end
