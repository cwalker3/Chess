# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/pawn_movement'

# pawn piece for chess
class Pawn < Piece
  include PawnMovement
  def moves(coords, board)
    pawn_moves(coords, board).select { |move_coords| board.valid_move?(coords, move_coords, color) }
  end

  def potential_moves(coords, board)
    pawn_moves(coords, board)
  end

  def to_s
    "\u265F"
  end
end
