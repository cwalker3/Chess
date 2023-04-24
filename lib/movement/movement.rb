# frozen_string_literal: true

# movement module for chess pieces
module Movement
  def up(coords)
    (coords[0] + next_char(coords[1])).to_sym
  end

  def down(coords)
    (coords[0] + prev_char(coords[1])).to_sym
  end

  def left(coords)
    (next_char(coords[0]) + coords[1]).to_sym
  end

  def right(coords)
    (prev_char(coords[0]) + coords[1]).to_sym
  end

  def next_char(char)
    (char.ord + 1).chr
  end

  def prev_char(char)
    (char.ord - 1).chr
  end
end
