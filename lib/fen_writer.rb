# frozen_string_literal: true

# module for creating a fen string from board state
module FenWriter

  def sudo_fen
    board_fen + castle_rights + en_passant_target.to_s
  end

  def board_fen
    string = ''
    board.each_value { |piece| string += char_for(piece) }
    string
  end

  def char_for(piece)
    char = piece_char(piece)
    if piece.is_a?(Piece) && piece.color == :white?
      char.upcase
    else
      char
    end
  end

  def piece_char(piece)
    if piece.is_a?(Pawn)
      'p'
    elsif piece.is_a?(Knight)
      'n'
    elsif piece.is_a?(Bishop)
      'b'
    elsif piece.is_a?(Rook)
      'r'
    elsif piece.is_a?(Queen)
      'q'
    elsif piece.is_a?(King)
      'k'
    else
      ' '
    end
  end
end
