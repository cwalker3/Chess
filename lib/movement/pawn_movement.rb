# frozen_string_literal: true

require_relative 'movement'

# pawn movement module
module PawnMovement
  include Movement

  def pawn_moves(position, board)
    if color == :white
      pawn_moves_white(position, board).flatten.compact
    else
      pawn_moves_black(position, board).flatten.compact
    end
  end

  def pawn_moves_white(position, board, moves = [])
    moves << forward_one_white(position, board)
    moves << forward_two_white(position, board)
    moves << capture_diagonal_white(position, board)
    moves << en_passant_white(position, board)
  end

  def pawn_moves_black(position, board, moves = [])
    moves << forward_one_black(position, board)
    moves << forward_two_black(position, board)
    moves << capture_diagonal_black(position, board)
    moves << en_passant_black(position, board)
  end

  def forward_one_white(position, board)
    move = up(position)
    move unless !board.valid_coords?(move) || board.occupied?(move)
  end

  def forward_one_black(position, board)
    move = down(position)
    move unless !board.valid_coords?(move) || board.occupied?(move)
  end

  def forward_two_white(position, board)
    return unless position[1] == '2'

    move = up(up(position))
    move unless !board.valid_coords?(move) || board.occupied?(move) || board.occupied?(up(position))
  end

  def forward_two_black(position, board)
    return unless position[1] == '7'

    move = down(down(position))
    move unless !board.valid_coords?(move) || board.occupied?(move) || board.occupied?(down(position))
  end

  def capture_diagonal_white(position, board)
    moves = [up(left(position)), up(right(position))]
    moves.select { |move| board.enemy?(position, move) }
  end

  def capture_diagonal_black(position, board)
    moves = [down(left(position)), down(right(position))]
    moves.select { |move| board.enemy?(position, move) }
  end

  def en_passant_white(position, board)
    diagonals = [up(right(position)), up(left(position))]
    en_passant = board.en_passant_target
    en_passant if diagonals.include?(en_passant) && board.enemy?(position, down(en_passant))
  end

  def en_passant_black(position, board)
    diagonals = [down(right(position)), down(left(position))]
    en_passant = board.en_passant_target
    en_passant if diagonals.include?(en_passant) && board.enemy?(position, up(en_passant))
  end
end
