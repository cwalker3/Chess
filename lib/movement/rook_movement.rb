# frozen_string_literal: true

require_relative 'movement'

# module for rook movement
module RookMovement
  include Movement
  def rook_moves(coords, board, moves = [])
    moves += up_moves(coords, board)
    moves += down_moves(coords, board)
    moves += left_moves(coords, board)
    moves + right_moves(coords, board)
  end

  def up_moves(coords, board, moves = [])
    move = coords
    loop do
      move = up(move)
      return moves if board.position[move].nil? || board.friendly?(coords, move)

      moves << move
      return moves if board.enemy?(coords, move)
    end
  end

  def down_moves(coords, board, moves = [])
    move = coords
    loop do
      move = down(move)
      return moves if board.position[move].nil? || board.friendly?(coords, move)

      moves << move
      return moves if board.enemy?(coords, move)
    end
  end

  def left_moves(coords, board, moves = [])
    move = coords
    loop do
      move = left(move)
      return moves if board.position[move].nil? || board.friendly?(coords, move)

      moves << move
      return moves if board.enemy?(coords, move)
    end
  end

  def right_moves(coords, board, moves = [])
    move = coords
    loop do
      move = right(move)
      return moves if board.position[move].nil? || board.friendly?(coords, move)

      moves << move
      return moves if board.enemy?(coords, move)
    end
  end
end