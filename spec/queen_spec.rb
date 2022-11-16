# frozen_string_literal: true

require_relative '../lib/pieces/queen'
require_relative '../lib/board'
require_relative '../lib/fen'

RSpec.describe Queen do

  subject(:queen) { described_class.new(:white) }
  
  describe 'moves' do
    context 'when queen is in the middle of the board' do
      let(:board) { Board.from_fen(Fen.new('8/8/8/8/3Q4/8/8/8 w - - 0 1')) }
      it 'returns the correct moves' do
        expect(queen.moves(:d4, board)).to eq(
          [:e5, :f6, :g7, :h8, :c5, :b6, :a7, :e3, :f2, :g1, :c3, :b2, :a1,
           :d5, :d6, :d7, :d8, :d3, :d2, :d1, :e4, :f4, :g4, :h4, :c4, :b4, :a4]
        )
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/8/2ppp3/2pQp3/2ppp3/8/8 w - - 0 1')) }
      it 'stops when she lands on an enemy' do
        expect(queen.moves(:d4, board)).to eq([:e5, :c5, :e3, :c3, :d5, :d3, :e4, :c4])
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/8/2PPP3/2PQP3/2PPP3/8/8 w - - 0 1')) }
      it 'stops when she lands on an enemy' do
        expect(queen.moves(:d4, board)).to eq([])
      end
    end
  end
end
