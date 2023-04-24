# frozen_string_literal: true

require_relative 'movement'

# module for knight movement
module KnightMovement
  include Movement
  def knight_moves(coords, board)
    l_moves(coords).filter { |move_coords| board.valid_coords?(move_coords) && !board.friendly?(coords, move_coords) }
  end

  def l_moves(coords, moves = [])
    moves << right(up(up(coords)))
    moves << right(right(up(coords)))
    moves << right(right(down(coords)))
    moves << right(down(down(coords)))
    moves << left(down(down(coords)))
    moves << left(left(down(coords)))
    moves << left(left(up(coords)))
    moves << left(up(up(coords)))
  end
end
