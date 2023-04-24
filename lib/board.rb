# frozen_string_literal: true

require_relative 'movement/castle'
require_relative 'movement/en_passant'
require_relative 'display'
require_relative 'promote'
require_relative 'fen_writer'

# board class for chess
class Board
  include Display
  include Castle
  include EnPassant
  include Promote
  include FenWriter

  attr_accessor :position, :castle_rights, :en_passant_coords, :history

  def initialize(position, castle_rights, en_passant_coords)
    @position = position
    @castle_rights = castle_rights
    @en_passant_coords = en_passant_coords
  end

  def update(piece_coords, move_coords)
    update_position(piece_coords, move_coords)
    promote_pawn(move_coords) if promotable?(move_coords)
    update_en_passant(piece_coords, move_coords)
    update_castle_rights(piece_coords)
  end

  def update_position(piece_coords, move_coords)
    if position[piece_coords].is_a?(Pawn) && move_coords == en_passant_coords
      en_passant_capture(coords)
    elsif position[piece_coords].is_a?(King) && !position[piece_coords].basic_moves(piece_coords, self).include?(move_coords)
      castle(move_coords)
    else
      move_piece(piece_coords, move_coords)
    end
  end

  def valid_piece?(coords)
    position[coords].is_a?(Piece) && position[coords].can_move?(coords, self)
  end

  def color_at(coords)
    position[coords].color
  end

  def valid_move_choice?(coords, move_coords)
    moves = position[coords].moves(coords, self)
    moves.include?(move_coords)
  end

  def checkmate?(color)
    check?(color) && no_moves?(color)
  end

  def check?(color)
    moves(enemy(color)).include?(king_coords(color))
  end

  def stalemate?(color)
    valid_moves(color).length.zero?
  end

  def insufficient_material?
    %i[white black].each do |color|
      return true if k_vs_k?(color) || k_vs_kb?(color) || k_vs_kn(color) || kb_vs_kb(color)
    end
    false
  end

  def valid_move?(coords, move_coords, color)
    copy = board_copy
    copy.update_position(coords, move_coords)
    !copy.check?(color)
  end

  def enemy?(coords, other_coords)
    position[other_coords].is_a?(Piece) && position[coords].color != position[other_coords].color
  end

  def friendly?(coords, other_coords)
    position[other_coords].is_a?(Piece) && position[coords].color == position[other_coords].color
  end

  def occupied?(coords)
    position[coords].is_a?(Piece)
  end

  def valid_coords?(coords)
    !position[coords].nil?
  end

  def ==(other)
    position == other.position && en_passant_coords == other.en_passant_coords && castle_rights == other.castle_rights
  end

  def display_moves(coords)
    display(position[coords].moves(coords, self))
  end

  private

  def board_copy
    Marshal.load(Marshal.dump(self))
  end

  def move_piece(coords, move_coords)
    position[move_coords] = position[coords]
    position[coords] = :empty
  end

  def enemy(color)
    color == :white ? :black : :white
  end

  def king_coords(color)
    position.key(King.new(color))
  end

  def moves(color, moves = [])
    pieces_coords(color).each do |coords|
      moves += position[coords].potential_moves(coords, self)
    end
    moves
  end

  def valid_moves(color, moves = [])
    pieces_coords(color).each do |coord|
      moves += position[coord].moves(coord, self)
    end
    moves
  end

  def no_moves?(color)
    valid_moves(color).length.zero?
  end

  def pieces_coords(color)
    position.select { |_coords, piece| piece.is_a?(Piece) && piece.color == color }.keys
  end

  def pieces(color)
    position.select { |_coords, piece| piece.is_a?(Piece) && piece.color == color }.values
  end

  def k_vs_k?(color)
    pieces(color).length == 1 \
    && pieces(enemy(color)).length == 1
  end

  def k_vs_kb?(color)
    pieces(color).length == 1 \
    && pieces(enemy(color)).length == 2 && pieces(enemy(color)).include?(Bishop.new(enemy(color)))
  end

  def k_vs_kn(color)
    pieces(color).length == 1 \
    && pieces(enemy(color)).length == 2 && pieces(enemy(color)).include?(Knight.new(enemy(color)))
  end

  def kb_vs_kb(color)
    pieces(color).length == 2 && pieces(color).include?(Bishop.new(color)) \
    && pieces(enemy(color)).length == 2 && pieces(enemy(color)).include?(Bishop.new(enemy(color))) \
    && same_bishops?
  end

  def same_bishops?
    square_color(position.key(Bishop.new(:white))) == square_color(position.key(Bishop.new(:black)))
  end
end
