# frozen_string_literal: true

require_relative 'piece'
require_relative '../movement/king_movement'

# king piece for chess
class King < Piece
  include KingMovement

  def moves(position, board)
    king_moves(position, board).select { |move| board.valid_move?(position, move, color) }
  end

  def potential_moves(position, board)
    basic_moves(position, board)
  end

  def to_s
    "\u265A"
  end
end
