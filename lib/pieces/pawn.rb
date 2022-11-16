# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/pawn_movement'

# pawn piece for chess
class Pawn < Piece
  include PawnMovement
  def moves(position, board)
    pawn_moves(position, board).select { |move| board.valid_move?(position, move, color) }
  end

  def potential_moves(position, board)
    pawn_moves(position, board)
  end

  def to_s
    "\u265F"
  end
end
