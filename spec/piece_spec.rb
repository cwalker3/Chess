# frozen_string_literal: true

require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/king'

describe Piece do
  describe '==' do
    it 'returns true when comparing 2 pieces of the same class and color' do
      piece1 = King.new(:black)
      piece2 = King.new(:black)
      expect(piece1 == piece2).to eq(true)
    end

    it 'returns false when comparing 2 pieces of the same class but different color' do
      piece1 = King.new(:black)
      piece2 = King.new(:white)
      expect(piece1 == piece2).to eq(false)
    end

    it 'returns true when comparing 2 pieces of the same color but different class' do
      piece1 = King.new(:black)
      piece2 = Pawn.new(:black)
      expect(piece1 == piece2).to eq(false)
    end
  end
end
