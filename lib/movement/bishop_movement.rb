# frozen_string_literal: true

require_relative 'movement'

# module for bishop movement
module BishopMovement
  include Movement
  def bishop_moves(position, board, moves = [])
    moves += up_left_moves(position, board)
    moves += up_right_moves(position, board)
    moves += down_left_moves(position, board)
    moves + down_right_moves(position, board)
  end

  def up_left_moves(position, board, moves = [])
    move = position
    loop do
      move = up(left(move))
      break if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      break if board.enemy?(position, move)
    end
    moves
  end

  def up_right_moves(position, board, moves = [])
    move = position
    loop do
      move = up(right(move))
      break if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      break if board.enemy?(position, move)
    end
    moves
  end

  def down_left_moves(position, board, moves = [])
    move = position
    loop do
      move = down(left(move))
      break if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      break if board.enemy?(position, move)
    end
    moves
  end

  def down_right_moves(position, board, moves = [])
    move = position
    loop do
      move = down(right(move))
      break if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      break if board.enemy?(position, move)
    end
    moves
  end
end
