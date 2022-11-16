# frozen_string_literal: true

require_relative 'movement'

# module containing methods related to en passant
module EnPassant
  include Movement

  def en_passant_capture(coords)
    board[en_passant_target] = board[coords]
    if board[coords] == Pawn.new(:white)
      board[down(en_passant_target)] = :empty
    else
      board[up(en_passant_target)] = :empty
    end
    board[coords] = :empty
  end

  def update_en_passant(position, move)
    @en_passant_target =
      if board[move] == Pawn.new(:white) && move == up(up(position))
        up(position)
      elsif board[move] == Pawn.new(:black) && move == down(down(position))
        down(position)
      else
        :none
      end
  end
end
