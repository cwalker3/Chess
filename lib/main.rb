# frozen_string_literal: true

require_relative 'game'
require_relative 'board'

def game_mode_input
  puts <<~HEREDOC

    1) Human vs Human
    2) Human vs Computer
    3) Computer vs Human
    4) Computer vs Computer

    Chose a game mode by entering the corresponding number.
  HEREDOC
  gets.chomp.to_i
end

def game_mode
  loop do
    input = gamemode_input
    return input if [1, 2, 3].include?(input)

    puts 'Invalid input'
    sleep 1
    redo
  end
end

def create_players(mode)
  case mode
  when 1
    [HumanPlayer.new, HumanPlayer.new]
  when 2
    [HumanPlayer.new, ComputerPlayer.new]
  when 3
    [ComputerPlayer.new, HumanPlayer.new]
  when 4
    [ComputerPlayer.new, ComputerPlayer.new]
  end
end

players = create_players(game_mode)
board = Board.new
game = game.new(board, players)

play(game)
