# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/bishop_movement'

# bishop piece for chess
class Bishop < Piece
  include BishopMovement
  def moves(position, board)
    bishop_moves(position, board).select { |move| board.valid_move?(position, move, color) }
  end

  def potential_moves(position, board)
    bishop_moves(position, board)
  end

  def to_s
    "\u265D"
  end
end
