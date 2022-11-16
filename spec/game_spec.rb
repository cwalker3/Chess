# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/fen'
require_relative '../lib/board'

describe Game do

  subject(:game) { Game.from_fen(Fen.new) }

  describe 'update_halfmove' do
    context 'when a piece is captured' do
      let(:game) { Game.from_fen(Fen.new('3k4/8/8/4b3/8/5N2/8/1K6 w - - 34 1')) }
      it 'resets the counter' do
        game.update_halfmove(:f3, :e5)
        expect(game.halfmove).to eq(0)
      end
    end

    context 'when a pawn is advanced' do
      let(:game) { Game.from_fen(Fen.new('5k2/8/4p3/8/8/8/8/1K6 w - - 44 1')) }
      it 'resets the counter' do
        game.update_halfmove(:e6, :e5)
        expect(game.halfmove).to eq(0)
      end
    end

    context 'when a piece is not captured and pawn not moved' do
      let(:game) { Game.from_fen(Fen.new('3k1b2/8/8/8/8/8/8/1K6 w - - 0 1')) }
      it 'resets the counter' do
        game.update_halfmove(:f8, :e7)
        expect(game.halfmove).to eq(1)
      end
    end
  end
end
