# frozen_string_literal: true

require_relative 'movement'

# module for bishop movement
module BishopMovement
  include Movement
  def bishop_moves(coords, board, moves = [])
    moves += up_left_moves(coords, board)
    moves += up_right_moves(coords, board)
    moves += down_left_moves(coords, board)
    moves + down_right_moves(coords, board)
  end

  def up_left_moves(coords, board, moves = [])
    move_coords = coords
    loop do
      move_coords = up(left(move_coords))
      break if board.position[move_coords].nil? || board.friendly?(coords, move_coords)

      moves << move_coords
      break if board.enemy?(coords, move_coords)
    end
    moves
  end

  def up_right_moves(coords, board, moves = [])
    move_coords = coords
    loop do
      move_coords = up(right(move_coords))
      break if board.position[move_coords].nil? || board.friendly?(coords, move_coords)

      moves << move_coords
      break if board.enemy?(coords, move_coords)
    end
    moves
  end

  def down_left_moves(coords, board, moves = [])
    move_coords = coords
    loop do
      move_coords = down(left(move_coords))
      break if board.position[move_coords].nil? || board.friendly?(coords, move_coords)

      moves << move_coords
      break if board.enemy?(coords, move_coords)
    end
    moves
  end

  def down_right_moves(coords, board, moves = [])
    move_coords = coords
    loop do
      move_coords = down(right(move_coords))
      break if board.position[move_coords].nil? || board.friendly?(coords, move_coords)

      moves << move_coords
      break if board.enemy?(coords, move_coords)
    end
    moves
  end
end
