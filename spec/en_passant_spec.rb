# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/fen_reader'

RSpec.describe EnPassant do

  subject(:board) { FenReader.new.board }

  describe 'update_en_passant' do
    context 'when a piece is moved that is not a pawn' do
      it 'updates en_passant to be none' do
        board.update_position(:g1, :f3)
        board.update_en_passant(:g1, :f3)
        expect(board.en_passant_coords).to eq(:-)
      end
    end

    context 'when a white pawn is moved one space' do
      it 'updates en_passant to be none' do
        board.update_position(:e2, :e3)
        board.update_en_passant(:e2, :e3)
        expect(board.en_passant_coords).to eq(:-)
      end
    end

    context 'when a white pawn is moved two spaces' do
      it 'updates en_passant to be the correct square' do
        board.update_position(:d2, :d4)
        board.update_en_passant(:d2, :d4)
        expect(board.en_passant_coords).to eq(:d3)
      end
    end

    context 'when a black pawn is moved two spaces' do
      it 'updates en_passant to be the correct square' do
        board.update_position(:e7, :e5)
        board.update_en_passant(:e7, :e5)
        expect(board.en_passant_coords).to eq(:e6)
      end
    end
  end

  describe 'en_passant_capture' do
    context 'when a white pawn makes an en passant capture' do
      let(:board) { FenReader.new('rnbqkbnr/ppp1pppp/8/3pP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 1').board }
      it 'updates the board correctly' do
        board.en_passant_capture(:e5)
        expect(board.position[:d6]).to be_a(Pawn)
        expect(board.position[:d5]).to eq(:empty)
      end
    end
  end
end
