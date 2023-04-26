# frozen_string_literal: true

require_relative '../lib/pieces/bishop'
require_relative '../lib/board'
require_relative '../lib/fen_reader'

RSpec.describe Bishop do

  subject(:bishop) { described_class.new(:white) }
  
  describe 'moves' do
    context 'when bishop is in the middle of the board' do
      let(:board) { FenReader.new('8/8/8/8/3B4/8/8/8 w - - 0 1').board }
      it 'returns the correct moves' do
        expect(bishop.moves(:d4, board)).to eq([:e5, :f6, :g7, :h8, :c5, :b6, :a7, :e3, :f2, :g1, :c3, :b2, :a1])
      end
    end

    context do
      let(:board) { FenReader.new('8/8/8/2p1p3/3B4/2p1p3/8/8 w - - 0 1').board }
      it 'stops when it reaches an enemy piece' do
        expect(bishop.moves(:d4, board)).to eq([:e5, :c5, :e3, :c3])
      end
    end

    context do
      let(:board) { FenReader.new('8/8/8/2P1P3/3B4/2P1P3/8/8 w - - 0 1').board }
      it 'cannot move through friendly pieces' do
        expect(bishop.moves(:d4, board)).to eq([])
      end
    end
  end
end