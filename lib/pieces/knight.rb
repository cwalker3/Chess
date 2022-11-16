# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/knight_movement'

# knight piece for chess
class Knight < Piece
  include KnightMovement
  def moves(position, board)
    knight_moves(position, board).select { |move| board.valid_move?(position, move, color) }
  end

  def potential_moves(position, board)
    knight_moves(position, board)
  end

  def to_s
    "\u265E"
  end
end
