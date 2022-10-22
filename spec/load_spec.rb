# frozen_string_literal: true

require_relative '../lib/load'

describe Load do
  describe '.fen' do
    it 'returns the default FEN from the default save file' do
      allow(described_class).to receive(:prompt_file_input).and_return(0)
      expect(described_class.fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1')
    end
  end
end
