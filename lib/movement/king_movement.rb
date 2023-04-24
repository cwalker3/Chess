# frozen_string_literal: true

require_relative 'movement'

# module for king movement
module KingMovement
  include Movement

  def king_moves(coords, board, moves = [])
    moves << basic_moves(coords, board)
    moves << if color == :white
               castle_white(coords, board)
             else
               castle_black(coords, board)
             end
    moves.compact.flatten
  end

  def basic_moves(coords, board, moves = [])
    moves << up(coords)
    moves << up(right(coords))
    moves << right(coords)
    moves << down(right(coords))
    moves << down(coords)
    moves << down(left(coords))
    moves << left(coords)
    moves << up(left(coords))
    moves.select { |move| board.valid_coords?(move) && !board.friendly?(coords, move) }
  end

  def castle_white(coords, board, moves = [])
    moves << :c1 if board.castle_rights.include?('Q') && valid_queen_castle?(coords, board)
    moves << :g1 if board.castle_rights.include?('K') && valid_king_castle?(coords, board)
  end

  def castle_black(coords, board, moves = [])
    moves << :c8 if board.castle_rights.include?('q') && valid_queen_castle?(coords, board)
    moves << :g8 if board.castle_rights.include?('k') && valid_king_castle?(coords, board)
  end

  def valid_queen_castle?(coords, board)
    !board.check?(color) \
    && board.valid_move?(coords, left(coords), color) && !board.occupied?(left(coords)) \
    && board.valid_move?(coords, left(left(coords)), color) && !board.occupied?(left(left(coords)))
  end

  def valid_king_castle?(coords, board)
    !board.check?(color) \
    && board.valid_move?(coords, right(coords), color) && !board.occupied?(right(coords)) \
    && board.valid_move?(coords, right(right(coords)), color) && !board.occupied?(right(right(coords)))
  end
end
