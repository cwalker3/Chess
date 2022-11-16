# frozen_string_literal: true

require_relative 'movement'

# module for rook movement
module RookMovement
  include Movement
  def rook_moves(position, board, moves = [])
    moves += up_moves(position, board)
    moves += down_moves(position, board)
    moves += left_moves(position, board)
    moves + right_moves(position, board)
  end

  def up_moves(position, board, moves = [])
    move = position
    loop do
      move = up(move)
      return moves if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      return moves if board.enemy?(position, move)
    end
  end

  def down_moves(position, board, moves = [])
    move = position
    loop do
      move = down(move)
      return moves if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      return moves if board.enemy?(position, move)
    end
  end

  def left_moves(position, board, moves = [])
    move = position
    loop do
      move = left(move)
      return moves if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      return moves if board.enemy?(position, move)
    end
  end

  def right_moves(position, board, moves = [])
    move = position
    loop do
      move = right(move)
      return moves if board.board[move].nil? || board.friendly?(position, move)

      moves << move
      return moves if board.enemy?(position, move)
    end
  end
end