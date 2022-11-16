# frozen_string_literal: true

require_relative '../lib/pieces/rook'
require_relative '../lib/board'
require_relative '../lib/fen'

RSpec.describe Rook do

  subject(:rook) { described_class.new(:white) }
  
  describe 'moves' do
    context 'when bishop is in the middle of the board' do
      let(:board) { Board.from_fen(Fen.new('8/8/8/8/3R4/8/8/8 w - - 0 1')) }
      it 'returns the correct moves' do
        expect(rook.moves(:d4, board)).to eq([:d5, :d6, :d7, :d8, :d3, :d2, :d1, :e4, :f4, :g4, :h4, :c4, :b4, :a4])
      end
    end

    context do
      let(:board) { Board.from_fen(Fen.new('8/8/8/3p4/2pRp3/3p4/8/8 w - - 0 1')) }
      it 'stops when it reaches an enemy piece' do
        expect(rook.moves(:d4, board)).to eq([:d5, :d3, :e4, :c4])
      end
    end

    context 'when bishop is in the middle of the board' do
      let(:board) { Board.from_fen(Fen.new('8/8/8/3P4/2PRP3/3P4/8/8 w - - 0 1')) }
      it 'cannnot move through friendly pieces' do
        expect(rook.moves(:d4, board)).to eq([])
      end
    end
  end
end
