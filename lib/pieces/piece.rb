# frozen_string_literal: true

# abstract piece class
class Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def ==(other)
    self.class == other.class && color == other.color
  end

  def can_move?(position, board)
    moves(position, board).length.positive?
  end
end
