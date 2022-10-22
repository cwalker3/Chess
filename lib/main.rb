# frozen_string_literal: true

require_relative 'game'
require_relative 'load'
require_relative 'board'
require_relative 'player'
require_relative 'piece'
require_relative 'pawn'
require_relative 'knight'
require_relative 'bishop'
require_relative 'rook'
require_relative 'queen'
require_relative 'king'

def introduction
  <<-HEREDOC
    Welcome to my command line chess game.
    This a player vs player game.
    There is no AI implemented.

  HEREDOC
end

def load_game?
  load_input == '1'
end

def load_input
  puts 'Enter 1 to load a game, or any other input to start a new game:'
  gets.chomp
end

DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'

puts introduction
game = load_game? ? Game.new(Load.fen) : Game.new(DEFAULT_FEN)
game.play
