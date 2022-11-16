# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/fen'

RSpec.describe EnPassant do

  subject(:board) { Board.from_fen(Fen.new) }

  describe 'update_en_passant' do
    context 'when a piece is moved that is not a pawn' do
      it 'updates en_passant to be none' do
        board.update_hash(:g1, :f3)
        board.update_en_passant(:g1, :f3)
        expect(board.en_passant_target).to eq(:none)
      end
    end

    context 'when a white pawn is moved one space' do
      it 'updates en_passant to be none' do
        board.update_hash(:e2, :e3)
        board.update_en_passant(:e2, :e3)
        expect(board.en_passant_target).to eq(:none)
      end
    end

    context 'when a white pawn is moved two spaces' do
      it 'updates en_passant to be the correct square' do
        board.update_hash(:d2, :d4)
        board.update_en_passant(:d2, :d4)
        expect(board.en_passant_target).to eq(:d3)
      end
    end

    context 'when a black pawn is moved two spaces' do
      it 'updates en_passant to be the correct square' do
        board.update_hash(:e7, :e5)
        board.update_en_passant(:e7, :e5)
        expect(board.en_passant_target).to eq(:e6)
      end
    end
  end

  describe 'en_passant_capture' do
    context 'when a white pawn makes an en passant capture' do
      let(:board) { Board.from_fen(Fen.new('rnbqkbnr/ppp1pppp/8/3pP3/8/8/PPPP1PPP/RNBQKBNR w KQkq d6 0 1')) }
      it 'updates the board correctly' do
        board.en_passant_capture(:e5)
        expect(board.board[:d6]).to be_a(Pawn)
        expect(board.board[:d5]).to eq(:empty)
      end
    end
  end
end
