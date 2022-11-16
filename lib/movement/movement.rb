# frozen_string_literal: true

# movement module for chess pieces
module Movement
  def up(position)
    (position[0] + next_char(position[1])).to_sym
  end

  def down(position)
    (position[0] + prev_char(position[1])).to_sym
  end

  def left(position)
    (next_char(position[0]) + position[1]).to_sym
  end

  def right(position)
    (prev_char(position[0]) + position[1]).to_sym
  end

  def next_char(char)
    (char.ord + 1).chr
  end

  def prev_char(char)
    (char.ord - 1).chr
  end
end
