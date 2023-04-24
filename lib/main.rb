# frozen_string_literal: true

require_relative 'game'
require_relative 'save_load'
require_relative 'fen_reader'
require_relative 'fen_writer'
require_relative 'board'
require_relative 'player'
require_relative 'display'
require_relative 'pieces/piece'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'movement/movement'
require_relative 'movement/pawn_movement'
require_relative 'movement/knight_movement'
require_relative 'movement/bishop_movement'
require_relative 'movement/rook_movement'
require_relative 'movement/king_movement'

system('clear')
puts <<~INTRODUCTION

  This is a player vs player command line chess game.


  Enter the number for the corresponding option:
    1) Start a new game
    2) Load a game
    3) Start a game from a FEN string

INTRODUCTION

choice = gets.chomp.to_i until [1, 2, 3].include?(choice)
case choice
when 1
  game = FenReader.new.game
when 2
  game = Game.load
when 3
  puts 'Enter a valid FEN string:'
  fen = gets.chomp
  game = FenReader.new(fen).game
end

game.play
