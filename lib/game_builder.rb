# frozen_string_literal: true

# class responsible for building a Game object with a board and players
class GameBuilder
  DEFAULT_FEN = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1'
  def self.build(fen = DEFAULT_FEN)
    Game.new(board(fen), players)
  end

  def board(fen)
    Board.from_fen(fen)
  end

  def players
    create_players(game_mode)
  end

  def create_players(mode)
    case mode
    when 1
      [Human.new(white), Human.new(black)]
    when 2
      [Human.new(white), Computer.new(black)]
    when 3
      [Computer.new(white), Human.new(black)]
    when 4
      [Computer.new(white), Computer.new(black)]
    end
  end

  def game_mode
    loop do
      input = gamemode_input
      return input if [1, 2, 3, 4].include?(input)

      puts 'Invalid input'
      sleep 1
      redo
    end
  end

  def game_mode_input
    puts <<~HEREDOC

      1) Human vs Human
      2) Human vs Computer
      3) Computer vs Human
      4) Computer vs Computer

      Choose a game mode by entering the corresponding number.
    HEREDOC
    gets.chomp.to_i
  end
end
