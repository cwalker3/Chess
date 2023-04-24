# frozen_string_literal: true

require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# class that builds a Game object from a fen string
class FenReader
  attr_reader :fen

  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  RANKS = ('1'..'8').to_a.freeze
  FILES = ('a'..'h').to_a.freeze
  PIECES = {
    'P' => Pawn,
    'N' => Knight,
    'B' => Bishop,
    'R' => Rook,
    'Q' => Queen,
    'K' => King
  }.freeze

  def initialize(fen = DEFAULT_FEN)
    @fen = fen.split
  end

  def game
    Game.new(board, current_player, halfmove)
  end

  def board
    Board.new(position, castle_rights, en_passant_coords)
  end

  def position
    position_hash = {}
    rank = 7
    rows.each do |row|
      file = 0
      row.each_char do |char|
        position_hash[(FILES[file] + RANKS[rank]).to_sym] = piece_for(char)
        file += 1
      end
      rank -= 1
    end
    position_hash
  end

  def current_player
    player == 'w' ? :white : :black
  end

  def castle_rights
    fen[2]
  end

  def en_passant_coords
    fen[3].to_sym
  end

  def halfmove
    fen[4].to_i
  end

  private

  def rows
    expand_spaces(fen[0]).split('/')
  end

  def expand_spaces(string)
    string = string.chars.map do |char|
      if char.to_i.positive?
        spaces = []
        char.to_i.times { spaces << 1 }
        spaces.flatten
      else
        char
      end
    end
    string.flatten.join
  end

  def piece_for(char)
    if char == '1'
      :empty
    else
      piece = PIECES[char.upcase]
      color = color_for(char)
      piece.new(color)
    end
  end

  def color_for(char)
    char == char.upcase ? :white : :black
  end

  def player
    fen[1]
  end
end
