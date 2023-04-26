# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/fen_reader'

describe Board do
  subject(:board) { FenReader.new.board }

  describe 'valid_piece?' do
  end

  describe 'checkmate' do

    context 'when white is not in checkmate' do
      it 'returns false' do
        expect(board.checkmate?(:white)).to eq(false)
      end
    end

    context 'when white is in checkmate' do
      let(:board) { FenReader.new('8/8/8/8/8/2p5/1q6/K7 w - - 0 1').board }
      it 'returns true' do
        expect(board.checkmate?(:white)).to eq(true)
      end
    end

    context 'when black is not in checkmate' do
      let(:board) { FenReader.new('7k/6Q1/8/8/8/8/8/2K5 w - - 0 1').board }
      it 'returns false' do
        expect(board.checkmate?(:black)).to eq(false)
      end
    end

    context 'when black is in checkmate' do
      let(:board) { FenReader.new('7k/8/8/8/7R/8/8/2K3R1 w - - 0 1').board }
      it 'returns true' do
        expect(board.checkmate?(:black)).to eq(true)
      end
    end
  end

  describe 'check' do
    context 'when white is in check' do
      let(:board) { FenReader.new('8/8/8/8/8/2p5/1q6/K7 w - - 0 1').board }
      it 'returns true' do
        expect(board.check?(:white)).to eq(true)
      end
    end

    context 'when white is not in check' do
      let(:board) { FenReader.new.board }
      it 'returns true' do
        expect(board.check?(:white)).to eq(false)
      end
    end

    context 'when black is in check' do
      let(:board) { FenReader.new('3R3B/B7/2N1N3/1N3N2/R2k3R/1N3N2/2N1N3/B2R2B1 w - - 0 1').board }
      it 'returns true' do
        expect(board.check?(:black)).to eq(true)
      end
    end

    context 'when black is not in check' do
      let(:board) { FenReader.new('k7/1b6/8/3Q4/8/8/8/K7 w - - 0 1').board }
      it 'returns true' do
        expect(board.check?(:black)).to eq(false)
      end
    end
  end

  describe 'stalemate' do
    context 'when white is not in stalemate' do
      it 'returns false' do
        expect(board.stalemate?(:white)).to eq(false)
      end
    end

    context 'when white is in stalemate' do
      let(:board) { FenReader.new('3k4/8/8/8/8/2p5/1r6/K7 w - - 0 1').board }
      it 'returns true' do
        expect(board.stalemate?(:white)).to eq(true)
      end
    end

    context 'when black is not in stalemate' do
      let(:board) { FenReader.new('3k4/2R1B3/8/8/8/8/8/K7 w - - 0 1').board }
      it 'returns false' do
        expect(board.stalemate?(:black)).to eq(false)
      end
    end

    context 'when black is in stalemate' do
      let(:board) { FenReader.new('3k4/2R1R3/8/8/8/8/8/K7 w - - 0 1').board }
      it 'returns true' do
        expect(board.stalemate?(:black)).to eq(true)
      end
    end
  end

  describe 'insufficient_material?' do
    context 'when there is a King vs King' do
      let(:board) { FenReader.new('3k4/8/8/8/8/8/8/2K5 w - - 0 1').board }
      it 'returns true' do
        expect(board.insufficient_material?).to eq(true)
      end
    end

    context 'when there is a King vs King and Bishop' do
      let(:board) { FenReader.new('3k4/4b3/8/8/8/8/8/2K5 w - - 0 1').board }
      it 'returns true' do
        expect(board.insufficient_material?).to eq(true)
      end
    end

    context 'when there is a King vs King and Knight' do
      let(:board) { FenReader.new('3k4/8/8/8/8/8/3N4/2K5 w - - 0 1').board }
      it 'returns true' do
        expect(board.insufficient_material?).to eq(true)
      end
    end

    context 'when there is a King and Bishop vs King and Bishop (same square color bishops)' do
      let(:board) { FenReader.new('3k4/4b3/8/8/8/8/3B4/2K5 w - - 0 1').board }
      it 'returns true' do
        expect(board.insufficient_material?).to eq(true)
      end
    end

    context 'when there is a King and Bishop vs King and Bishop (different square color bishops)' do
      let(:board) { FenReader.new('3k4/5b2/8/8/8/8/3B4/2K5 w - - 0 1').board }
      it 'returns false' do
        expect(board.insufficient_material?).to eq(false)
      end
    end

    context 'with starting position' do
      it 'returns false' do
        expect(board.insufficient_material?).to eq(false)
      end
    end
  end

  describe 'valid_move?' do
    context 'when the move does not place the king in check' do
      it 'returns true' do
        expect(board.valid_move?(:e2, :e4, :white)).to eq(true)
      end
    end

    context 'when a piece is pinned to the king' do
      let(:board) { FenReader.new('3rk3/8/8/8/3Q4/8/8/3K4 w - - 0 1').board }
      it 'cannot move' do
        expect(board.valid_move?(:d4, :e4, :white)).to eq(false)
      end
    end

    context 'when the king tries to place itself in check' do
      let(:board) { FenReader.new('1k6/8/8/8/3q4/8/8/4K3 w - - 0 1').board }
      it 'returns false' do
        expect(board.valid_move?(:e1, :d1, :white)).to eq(false)
      end
    end
  end

  describe 'enemy?' do
    context do
      let(:enemy_board) { FenReader.new('8/8/8/3ppp2/4P3/8/8/8 w - - 0 1').board}
      it 'returns true with 2 pieces of a different color' do
        expect(enemy_board.enemy?(:e4, :d5)).to eq(true)
      end
    end
  end
end
