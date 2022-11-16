# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/bishop_movement'
require_relative '../movement/rook_movement'

# queen piece for chess board
class Queen < Piece
  include BishopMovement
  include RookMovement

  def moves(position, board)
    potential_moves(position, board).select { |move| board.valid_move?(position, move, color) }
  end

  def potential_moves(position, board)
    bishop_moves(position, board) + rook_moves(position, board)
  end

  def to_s
    "\u265B"
  end
end
