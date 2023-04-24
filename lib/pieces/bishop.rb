# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/bishop_movement'

# bishop piece for chess
class Bishop < Piece
  include BishopMovement
  def moves(coords, board)
    bishop_moves(coords, board).select { |move| board.valid_move?(coords, move, color) }
  end

  def potential_moves(coords, board)
    bishop_moves(coords, board)
  end

  def to_s
    "\u265D"
  end
end
