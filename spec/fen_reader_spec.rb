# frozen_string_literal: true

require_relative '../lib/fen_reader'
require_relative '../lib/board'

RSpec.describe FenReader do
  subject(:fen_default) { described_class.new }
  describe 'current_player' do
    context 'when using default fen' do
      it 'returns white' do
        expect(fen_default.current_player).to eq(:white)
      end
    end

    context 'when current player is black' do
      subject(:fen_black) { FenReader.new('rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1') }
      it 'returns black' do
        expect(fen_black.current_player).to eq(:black)
      end
    end
  end

  describe 'board' do
    it 'returns the default board' do
      expected = {
        a8: Rook.new(:black), b8: Knight.new(:black), c8: Bishop.new(:black), d8: Queen.new(:black), e8: King.new(:black), f8: Bishop.new(:black) , g8: Knight.new(:black), h8: Rook.new(:black), 
        a7: Pawn.new(:black), b7: Pawn.new(:black), c7: Pawn.new(:black), d7: Pawn.new(:black), e7: Pawn.new(:black), f7: Pawn.new(:black), g7: Pawn.new(:black), h7: Pawn.new(:black),
        a6: :empty, b6: :empty, c6: :empty, d6: :empty, e6: :empty, f6: :empty, g6: :empty, h6: :empty,
        a5: :empty, b5: :empty, c5: :empty, d5: :empty, e5: :empty, f5: :empty, g5: :empty, h5: :empty,
        a4: :empty, b4: :empty, c4: :empty, d4: :empty, e4: :empty, f4: :empty, g4: :empty, h4: :empty,
        a3: :empty, b3: :empty, c3: :empty, d3: :empty, e3: :empty, f3: :empty, g3: :empty, h3: :empty,
        a2: Pawn.new(:white), b2: Pawn.new(:white), c2: Pawn.new(:white), d2: Pawn.new(:white), e2: Pawn.new(:white), f2: Pawn.new(:white), g2: Pawn.new(:white), h2: Pawn.new(:white),
        a1: Rook.new(:white), b1: Knight.new(:white), c1: Bishop.new(:white), d1: Queen.new(:white), e1: King.new(:white), f1: Bishop.new(:white), g1: Knight.new(:white), h1: Rook.new(:white)
      }

      expect(fen_default.position).to eq(expected)
    end

    context 'when given a different fen string' do
      let(:fen_two) { FenReader.new('8/K7/8/8/8/1k6/1N1p4/8 w - - 0 1')}
      it 'returns the correct board' do
        expected = {
          a8: :empty, b8: :empty, c8: :empty, d8: :empty, e8: :empty, f8: :empty, g8: :empty, h8: :empty,
          a7: King.new(:white), b7: :empty, c7: :empty, d7: :empty, e7: :empty, f7: :empty, g7: :empty, h7: :empty,
          a6: :empty, b6: :empty, c6: :empty, d6: :empty, e6: :empty, f6: :empty, g6: :empty, h6: :empty,
          a5: :empty, b5: :empty, c5: :empty, d5: :empty, e5: :empty, f5: :empty, g5: :empty, h5: :empty,
          a4: :empty, b4: :empty, c4: :empty, d4: :empty, e4: :empty, f4: :empty, g4: :empty, h4: :empty,
          a3: :empty, b3: King.new(:black), c3: :empty, d3: :empty, e3: :empty, f3: :empty, g3: :empty, h3: :empty,
          a2: :empty, b2: Knight.new(:white), c2: :empty, d2: Pawn.new(:black), e2: :empty, f2: :empty, g2: :empty, h2: :empty,
          a1: :empty, b1: :empty, c1: :empty, d1: :empty, e1: :empty, f1: :empty, g1: :empty, h1: :empty
        }

        expect(fen_two.position).to eq(expected)
      end
    end
  end
end  
 

{
  a8: :empty, b8: :empty, c8: :empty, d8: :empty, e8: :empty, f8: :empty ,g8: :empty, h8: :empty, 
  a7: :empty, b7: :empty, c7: :empty, d7: :empty, e7: :empty, f7: :empty, g7: :empty, h7: :empty,
  a6: :empty, b6: :empty, c6: :empty, d6: :empty, e6: :empty, f6: :empty, g6: :empty, h6: :empty,
  a5: :empty, b5: :empty, c5: :empty, d5: :empty, e5: :empty, f5: :empty, g5: :empty, h5: :empty,
  a4: :empty, b4: :empty, c4: :empty, d4: :empty, e4: :empty, f4: :empty, g4: :empty, h4: :empty,
  a3: :empty, b3: :empty, c3: :empty, d3: :empty, e3: :empty, f3: :empty, g3: :empty, h3: :empty,
  a2: :empty, b2: :empty, c2: :empty, d2: :empty, e2: :empty, f2: :empty, g2: :empty, h2: :empty,
  a1: :empty, b1: :empty, c1: :empty, d1: :empty, e1: :empty, f1: :empty, g1: :empty, h1: :empty
}