# frozen_string_literal: true

require_relative 'movement'

# module for knight movement
module KnightMovement
  include Movement
  def knight_moves(position, board)
    l_moves(position).filter { |move| board.valid_coords?(move) && !board.friendly?(position, move) }
  end

  def l_moves(position, moves = [])
    moves << right(up(up(position)))
    moves << right(right(up(position)))
    moves << right(right(down(position)))
    moves << right(down(down(position)))
    moves << left(down(down(position)))
    moves << left(left(down(position)))
    moves << left(left(up(position)))
    moves << left(up(up(position)))
  end
end
