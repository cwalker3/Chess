# frozen_string_literal: true

# Piece class for chess board
class Piece
  def self.for(row, column)
    case row
    when 0
      piece_for(column, black)
    when 1
      Pawn.new(black)
    when 6
      Pawn.new(white)
    when 7
      piece_for(column, white)
    end
  end

  def piece_for(column, color)
    case column
    when 0, 7
      Rook.new(color)
    when 1, 6
      Knight.new(color)
    when 2, 5
      Bishop.new(color)
    when 3
      Queen.new(color)
    when 4
      King.new(color)
    end
  end


end
