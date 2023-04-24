# frozen_string_literal: true

require_relative 'movement'

# module containing methods related to en passant
module EnPassant
  include Movement

  def en_passant_capture(coords)
    position[en_passant_coords] = position[coords]
    if position[coords] == Pawn.new(:white)
      position[down(en_passant_coords)] = :empty
    else
      position[up(en_passant_coords)] = :empty
    end
    position[coords] = :empty
  end

  def update_en_passant(coords, move_coords)
    @en_passant_coords =
      if position[move_coords] == Pawn.new(:white) && move_coords == up(up(coords))
        up(coords)
      elsif position[move_coords] == Pawn.new(:black) && move_coords == down(down(coords))
        down(coords)
      else
        :-
      end
  end
end
