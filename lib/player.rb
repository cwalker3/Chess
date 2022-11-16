# frozen_string_literal: true

# player class for chess game
class Player
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def choose_piece
    puts "#{color.capitalize}'s turn, choose a piece to move. Enter a rank and a file, for example, 'e2'\n
    You can also enter 'save', 'resign', 'offer_draw'"
    gets.chomp.downcase.to_sym
  end

  def choose_move
    puts "Enter a rank and a file for a square for this piece to move to.\n
    You can also enter 'back' to select a different piece."
    gets.chomp.downcase.to_sym
  end

  def accept_draw?(player)
    puts "#{player.color.capitalize} has offered a draw. Enter 'y' to accept."
    gets.chomp.downcase == 'y'
  end
end
