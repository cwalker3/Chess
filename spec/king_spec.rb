# frozen_string_literal: true

require_relative '../lib/pieces/king'
require_relative '../lib/board'
require_relative '../lib/fen_reader'

RSpec.describe King do
  describe 'moves' do
    context 'when king is in the middle of the board' do
      let(:board) { FenReader.new('8/8/8/8/3K4/8/8/8 w - - 0 1').board }
      it 'returns the correct moves' do
        expect(board.position[:d4].moves(:d4, board)).to eq([:d5, :c5, :c4, :c3, :d3, :e3, :e4, :e5])
      end
    end

    context do
      let(:board) { FenReader.new('8/8/8/2p1p3/3K4/2p1p3/8/8 w - - 0 1').board }
      it 'can capture enemy pieces' do
        expect(board.position[:d4].moves(:d4, board)).to eq([:d5, :c5, :c4, :c3, :d3, :e3, :e4, :e5])
      end
    end

    context do
      let(:board) { FenReader.new('8/8/8/2PPP3/2PKP3/2PPP3/8/8 w - - 0 1').board }
      it 'cannot move on friendly pieces' do
        expect(board.position[:d4].moves(:d4, board)).to eq([])
      end
    end

    context 'when white King can castle' do
      let(:board) { FenReader.new('r3k2r/8/8/8/8/8/8/R3K2R w KQkq - 0 1').board }
      it 'returns the correct moves' do
        expect(board.position[:e1].moves(:e1, board)).to eq([:e2, :d2, :d1, :f1, :f2, :c1, :g1])
      end
    end

    context 'when black King can castle' do
      let(:board) { FenReader.new('r3k2r/8/8/8/8/8/8/R3K2R w KQkq - 0 1').board }
      it 'returns the correct moves' do
        expect(board.position[:e8].moves(:e8, board)).to eq([:d8, :d7, :e7, :f7, :f8, :c8, :g8])
      end
    end

    context 'when white King would move through check to castle' do
      let(:board) { FenReader.new('2k5/8/8/8/8/8/4b3/R3K2R w KQ - 0 1').board }
      it 'cannot castle' do
        expect(board.position[:e1].moves(:e1, board)).to eq([:e2, :d2, :f2])
      end
    end

    context 'when black King is in check' do
      let(:board) { FenReader.new('r3k2r/8/8/8/8/8/8/2K1R3 w kq - 0 1').board }
      it 'cannot castle' do
        expect(board.position[:e8].moves(:e8, board)).to eq([:d8, :d7, :f7, :f8])
      end
    end
  end
end
