# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/rook_movement'

# rook piece for chess
class Rook < Piece
  include RookMovement
  def moves(position, board)
    rook_moves(position, board).select { |move| board.valid_move?(position, move, color)}
  end

  def potential_moves(position, board)
    rook_moves(position, board)
  end

  def to_s
    "\u265C"
  end
end
