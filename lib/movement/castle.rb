# frozen_string_literal: true

# module containing methods related to castling
module Castle
  def castle(move)
    case move
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
    board[:c1] = board[:e1]
    board[:e1] = :empty
    board[:d1] = board[:a1]
    board[:a1] = :empty
  end

  def king_castle_white
    board[:g1] = board[:e1]
    board[:e1] = :empty
    board[:f1] = board[:h1]
    board[:h1] = :empty
  end

  def queen_castle_black
    board[:c8] = board[:e8]
    board[:e8] = :empty
    board[:d8] = board[:a8]
    board[:a8] = :empty
  end

  def king_castle_black
    board[:g8] = board[:e8]
    board[:e8] = :empty
    board[:f8] = board[:h8]
    board[:h8] = :empty
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
