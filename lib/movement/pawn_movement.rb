# frozen_string_literal: true

require_relative 'movement'

# pawn movement module
module PawnMovement
  include Movement

  def pawn_moves(coords, board)
    if color == :white
      pawn_moves_white(coords, board).flatten.compact
    else
      pawn_moves_black(coords, board).flatten.compact
    end
  end

  def pawn_moves_white(coords, board, moves = [])
    moves << forward_one_white(coords, board)
    moves << forward_two_white(coords, board)
    moves << capture_diagonal_white(coords, board)
    moves << en_passant_white(coords, board)
  end

  def pawn_moves_black(coords, board, moves = [])
    moves << forward_one_black(coords, board)
    moves << forward_two_black(coords, board)
    moves << capture_diagonal_black(coords, board)
    moves << en_passant_black(coords, board)
  end

  def forward_one_white(coords, board)
    move_coords = up(coords)
    move_coords unless !board.valid_coords?(move_coords) || board.occupied?(move_coords)
  end

  def forward_one_black(coords, board)
    move_coords = down(coords)
    move_coords unless !board.valid_coords?(move_coords) || board.occupied?(move_coords)
  end

  def forward_two_white(coords, board)
    return unless coords[1] == '2'

    move_coords = up(up(coords))
    move_coords unless !board.valid_coords?(move_coords) || board.occupied?(move_coords) || board.occupied?(up(coords))
  end

  def forward_two_black(coords, board)
    return unless coords[1] == '7'

    move_coords = down(down(coords))
    move_coords unless !board.valid_coords?(move_coords) || board.occupied?(move_coords) || board.occupied?(down(coords))
  end

  def capture_diagonal_white(coords, board)
    moves = [up(left(coords)), up(right(coords))]
    moves.select { |move_coords| board.enemy?(coords, move_coords) }
  end

  def capture_diagonal_black(coords, board)
    moves = [down(left(coords)), down(right(coords))]
    moves.select { |move_coords| board.enemy?(coords, move_coords) }
  end

  def en_passant_white(coords, board)
    diagonals = [up(right(coords)), up(left(coords))]
    en_passant = board.en_passant_coords
    en_passant if diagonals.include?(en_passant) && board.enemy?(coords, down(en_passant))
  end

  def en_passant_black(coords, board)
    diagonals = [down(right(coords)), down(left(coords))]
    en_passant = board.en_passant_coords
    en_passant if diagonals.include?(en_passant) && board.enemy?(coords, up(en_passant))
  end
end
