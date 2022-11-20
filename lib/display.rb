# frozen_string_literal: true

require 'colorize'

# module for displaying chess board
module Display
  def display(moves = [])
    system('clear')
    board.each_key do |coords|
      print coords[1] if coords[0] == 'a'
      print_square(coords, moves)
      print "\n" if coords[0] == 'h'
    end
    puts '  a  b  c  d  e  f  g  h'
  end

  private

  def print_square(coords, moves)
    print string_for(coords, moves).colorize(color: piece_color(coords, moves), background: square_color(coords, moves))
  end

  def piece_color(coords, moves)
    if occupied?(coords)
      board[coords].color == :white ? :light_white : :black
    elsif moves.include?(coords)
      :red
    else
      :black
    end
  end

  def string_for(coords, moves)
    if occupied?(coords)
      "\u2009#{board[coords]}\u2009"
    elsif moves.include?(coords)
      "\u2009\u2B24\u2009"
    else
      '   '
    end
  end

  def square_color(coords, moves)
    if moves.include?(coords) && occupied?(coords)
      :red
    else
      ((coords[0].ord + coords[1].ord) % 2).zero? ? :light_blue : :white
    end
  end
end
