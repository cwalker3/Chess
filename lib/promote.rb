# frozen_string_literal: true

require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'

# module containing methods related to promoting a pawn
module Promote
  def promote_pawn(move)
    
    choice = promote_input
    color = position[move].color
    position[move] = choices[choice].new(color)
  end

  def promotable?(move)
    position[move] == Pawn.new(:white) && move[1] == '8' \
    || position[move] == Pawn.new(:black) && move[1] == '1'
  end

  def promote_input
    loop do
      prompt_promote
      choice = gets.chomp.downcase.to_sym
      return choice if choices.keys.include?(choice)

      puts 'Invalid choice.'
      sleep 1
    end
  end

  def prompt_promote
    puts <<~PROMOTE
      Enter the corresponding character to promote your pawn:

        Q) Queen
        R) Rook
        B) Bishop
        N) Knight
    PROMOTE
  end

  def choices
    {
      q: Queen,
      r: Rook,
      b: Bishop,
      n: Knight
    }
  end
end
