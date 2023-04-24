# frozen_string_literal: true

# module containing methods related to castling
module Castle
  def castle(move_coords)
    case move_coords
    when :c1
      queen_castle_white
    when :g1
      king_castle_white
    when :c8
      queen_castle_black
    when :g8
      king_castle_black
    end
  end

  def queen_castle_white
    position[:c1] = position[:e1]
    position[:e1] = :empty
    position[:d1] = position[:a1]
    position[:a1] = :empty
  end

  def king_castle_white
    position[:g1] = position[:e1]
    position[:e1] = :empty
    position[:f1] = position[:h1]
    position[:h1] = :empty
  end

  def queen_castle_black
    position[:c8] = position[:e8]
    position[:e8] = :empty
    position[:d8] = position[:a8]
    position[:a8] = :empty
  end

  def king_castle_black
    position[:g8] = position[:e8]
    position[:e8] = :empty
    position[:f8] = position[:h8]
    position[:h8] = :empty
  end

  def update_castle_rights(position)
    case position
    when :e1
      @castle_rights = castle_rights.delete('QK')
    when :e8
      @castle_rights = castle_rights.delete('qk')
    when :a1
      @castle_rights = castle_rights.delete('Q')
    when :h1
      @castle_rights = castle_rights.delete('K')
    when :a8
      @castle_rights = castle_rights.delete('q')
    when :h8
      @castle_rights = castle_rights.delete('k')
    end
  end
end
