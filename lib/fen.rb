# frozen_string_literal: true

require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# class that reads FEN strings to create a chess game object
class Fen
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

  def board
    board = {}
    rank = 7
    rows.each do |row|
      file = 0
      row.each_char do |char|
        board[(FILES[file] + RANKS[rank]).to_sym] = piece_for(char)
        file += 1
      end
      rank -= 1
    end
    board
  end

  def current_player
    player == 'w' ? :white : :black
  end

  def castle_rights
    fen[2]
  end

  def en_passant
    fen[3].to_sym
  end

  def halfmove
    fen[4].to_i
  end

  private

  def rows
    expand_spaces(placement).split('/')
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

  def placement
    fen[0]
  end

  def player
    fen[1]
  end
end
