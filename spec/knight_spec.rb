# frozen_string_literal: true

require_relative '../lib/pieces/knight'
require_relative '../lib/board'
require_relative '../lib/fen'

RSpec.describe Knight do

  subject(:knight) { described_class.new(:white) }
  
  describe 'moves' do
    context 'when knight has 8 moves' do
      let(:board) { Board.from_fen(Fen.new('8/8/8/8/3N4/8/8/8 w - - 0 1')) }
      it 'returns all 8 moves' do
        expect(knight.moves(:d4, board)).to eq([:c6, :b5, :b3, :c2, :e2, :f3, :f5, :e6])
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/8/2ppp3/2pNp3/2ppp3/8/8 w - - 0 1'))}
      it 'can jump over pieces' do
        expect(knight.moves(:d4, board)).to eq([:c6, :b5, :b3, :c2, :e2, :f3, :f5, :e6])
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/2p1p3/1p3p2/3N4/1p3p2/2p1p3/8 w - - 0 1'))}
      it 'can land on enemy pieces' do
        expect(knight.moves(:d4, board)).to eq([:c6, :b5, :b3, :c2, :e2, :f3, :f5, :e6])
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/2P1P3/1P3P2/3N4/1P3P2/2P1P3/8 w - - 0 1'))}
      it 'cannot land on friendly pieces' do
        expect(knight.moves(:d4, board)).to eq([])
      end
    end
  end
end
