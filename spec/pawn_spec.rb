# frozen_string_literal: true

require_relative '../lib/pieces/pawn'
require_relative '../lib/board'
require_relative '../lib/fen_reader'

RSpec.describe Pawn do
  
  describe 'moves' do
    context 'when white pawn is on rank 2' do
      let(:board) { FenReader.new('8/8/8/8/8/8/4P3/8 w - - 0 1').board }
      it 'can move 1 or 2 spaces' do
        expect(board.position[:e2].moves(:e2, board)).to eq([:e3, :e4])
      end
    end

    context 'when white pawn is on rank 3' do
      let(:board) { FenReader.new('8/8/8/8/8/4P3/8/8 w - - 0 1').board }
      it 'can move 1 space' do
        expect(board.position[:e3].moves(:e3, board)).to eq([:e4])
      end
    end

    context 'when there is a piece in front of white pawn' do
      let(:board) { FenReader.new('8/8/8/8/4p3/4P3/8/8 w - - 0 1').board }
      it 'cannot move forward' do
        expect(board.position[:e3].moves(:e3, board)).to eq([])
      end
    end


    context 'when there are pieces diagonal to white pawn' do
      let(:board) { FenReader.new('8/8/8/3ppp2/4P3/8/8/8 w - - 0 1').board }
      it 'can capture diagonal' do
        expect(board.position[:e4].moves(:e4, board)).to eq([:f5, :d5])
      end
    end

    context 'when white pawn has en passant available' do
      let(:board) { FenReader.new('8/8/4p3/3pP3/8/8/8/8 w - d6 0 1').board }
      it 'returns en passant target' do
        expect(board.position[:e5].moves(:e5, board)).to eq([:d6])
      end
    end

    context 'when black pawn can move forward 2 or capture diagonal' do
      let(:board) { FenReader.new('8/4p3/3P1P2/8/8/8/8/8 w - - 0 1').board }
      it 'returns the correct moves' do
        expect(board.position[:e7].moves(:e7, board)).to eq([:e6, :e5, :f6, :d6])
      end
    end

    context 'when black pawn can en passant' do
      let(:board) { FenReader.new('8/8/8/8/8/3Pp3/4P3/8 w - d2 0 1').board }
      it 'returns en passant target' do
        expect(board.position[:e3].moves(:e3, board)).to eq([:d2])
      end
    end
  end
end
