# frozen_string_literal: true

require_relative 'save_load'
require_relative 'player'

# game class for Chess
class Game
  include SaveLoad

  attr_reader :board, :players, :history, :halfmove, :current_player

  def initialize(board, current_player, halfmove)
    @board = board
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = current_player == :white ? players[0] : players[1]
    @halfmove = halfmove
    @history = [board.sudo_fen]
  end

  def play
    until game_over?(current_player.color)
      player_turn
      @history << board.sudo_fen
      @current_player = next_player
    end
    end_game(current_player.color)
  end

  def player_turn
    piece_coords, move_coords = nil
    loop do
      piece_coords = player_choose_piece
      move_coords = player_choose_move(piece_coords)
      break unless move_coords == :back
    end
    update_halfmove(piece_coords, move_coords)
    board.update(piece_coords, move_coords)
  end

  def player_choose_piece
    loop do
      board.display
      choice = current_player.choose_piece.to_sym
      if actions.include?(choice)
        send(choice)
      else
        return choice if valid_piece?(choice)

        invalid_choice
      end
    end
  end

  def player_choose_move(coords)
    loop do
      board.display_moves(coords)
      choice = current_player.choose_move
      return choice if board.valid_move_choice?(coords, choice) || choice == :back

      invalid_choice
    end
  end

  def update_halfmove(piece_coords, move_coords)
    @halfmove =
      if board.occupied?(move_coords) || board.position[piece_coords].is_a?(Pawn)
        0
      else
        halfmove + 1
      end
  end

  def next_player
    current_player.color == :white ? players[1] : players[0]
  end

  def game_over?(color)
    board.checkmate?(color) || board.stalemate?(color) || halfmove >= 100 || board.insufficient_material? || three_rep?
  end

  def end_game(color)
    board.display
    sleep 1
    end_game_message(color)
    sleep 2
    exit_game
  end

  private

  def valid_piece?(choice)
    choice.length == 2 && board.valid_piece?(choice) && board.color_at(choice) == current_player.color
  end

  def end_game_message(color)
    if board.checkmate?(color)
      puts "Checkmate, #{next_player.color.capitalize} wins."
    elsif board.stalemate?(color)
      puts 'Stalemate, game ends in a draw.'
    elsif halfmove >= 100
      puts 'No pawn moves or piece captures in 50 turns, game ends in a draw.'
    elsif board.insufficient_material?
      puts 'Insufficient material to checkmate. Game ends in a draw.'
    elsif three_rep?
      puts 'Position reached 3 times, game ends in a draw.'
    end
  end

  def three_rep?
    history.tally.values.include?(3)
  end

  def actions
    %i[save resign offer_draw]
  end

  def resign
    puts "#{current_player.color.capitalize} resigns. #{next_player.color.capitalize} wins."
    sleep 2
    exit_game
  end

  def offer_draw
    if next_player.accept_draw?(current_player)
      puts 'Draw offer accepted.'
      sleep 1
      exit_game
    else
      puts 'Draw offer declined.'
      sleep 1
    end
  end

  def invalid_choice
    puts 'Invalid choice.'
    sleep 1
  end

  def exit_game
    puts 'Thank you for playing'
    sleep 2
    exit
  end
end
