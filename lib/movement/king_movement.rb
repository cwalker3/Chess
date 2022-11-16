# frozen_string_literal: true

require_relative 'movement'

# module for king movement
module KingMovement
  include Movement

  def king_moves(position, board, moves = [])
    moves << basic_moves(position, board)
    moves << if color == :white
               castle_white(position, board)
             else
               castle_black(position, board)
             end
    moves.compact.flatten
  end

  def basic_moves(position, board, moves = [])
    moves << up(position)
    moves << up(right(position))
    moves << right(position)
    moves << down(right(position))
    moves << down(position)
    moves << down(left(position))
    moves << left(position)
    moves << up(left(position))
    moves.select { |move| board.valid_coords?(move) && !board.friendly?(position, move) }
  end

  def castle_white(position, board, moves = [])
    moves << :c1 if board.castle_rights.include?('Q') && valid_queen_castle?(position, board)
    moves << :g1 if board.castle_rights.include?('K') && valid_king_castle?(position, board)
  end

  def castle_black(position, board, moves = [])
    moves << :c8 if board.castle_rights.include?('q') && valid_queen_castle?(position, board)
    moves << :g8 if board.castle_rights.include?('k') && valid_king_castle?(position, board)
  end

  def valid_queen_castle?(position, board)
    !board.check?(color) \
    && board.valid_move?(position, left(position), color) && !board.occupied?(left(position)) \
    && board.valid_move?(position, left(left(position)), color) && !board.occupied?(left(left(position)))
  end

  def valid_king_castle?(position, board)
    !board.check?(color) \
    && board.valid_move?(position, right(position), color) && !board.occupied?(right(position)) \
    && board.valid_move?(position, right(right(position)), color) && !board.occupied?(right(right(position)))
  end
end
