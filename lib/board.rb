# frozen_string_literal: true

require_relative 'movement/castle'
require_relative 'movement/en_passant'
require_relative 'display'
require_relative 'promote'

# board class for chess
class Board
  include Castle
  include EnPassant
  include Display
  include Promote

  def self.from_fen(fen)
    board = fen.board
    castle_rights = fen.castle_rights
    en_passant = fen.en_passant
    new(board, castle_rights, en_passant)
  end

  attr_accessor :board, :castle_rights, :en_passant_target, :history

  def initialize(board, castle_rights, en_passant)
    @board = board
    @castle_rights = castle_rights
    @en_passant_target = en_passant
  end

  def update_board(coords, move, game)
    update_hash(coords, move)
    promote_pawn(move) if promotable?(move)
    update_en_passant(coords, move)
    update_castle_rights(coords)
    game.history << sudo_fen
  end

  def update_hash(coords, move)
    if board[coords].is_a?(Pawn) && move == en_passant_target
      en_passant_capture(coords)
    elsif board[coords].is_a?(King) && !board[coords].basic_moves(coords, self).include?(move)
      castle(move)
    else
      move_piece(coords, move)
    end
  end

  def valid_piece?(coords)
    board[coords].is_a?(Piece) && board[coords].can_move?(coords, self)
  end

  def color_at(coords)
    board[coords].color
  end

  def valid_move_choice?(coords, move_coords)
    moves = board[coords].moves(coords, self)
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

  def valid_move?(position, move, color)
    copy = board_copy
    copy.update_hash(position, move)
    !copy.check?(color)
  end

  def enemy?(position, other)
    board[other].is_a?(Piece) && board[position].color != board[other].color
  end

  def friendly?(position, other)
    board[other].is_a?(Piece) && board[position].color == board[other].color
  end

  def occupied?(coords)
    board[coords].is_a?(Piece)
  end

  def valid_coords?(coords)
    !board[coords].nil?
  end

  def ==(other)
    board == other.board && en_passant_target == other.en_passant_target && castle_rights == other.castle_rights
  end

  def display_moves(coords)
    display(board[coords].moves(coords, self))
  end

  def sudo_fen
    string = ''
    board.each_value { |piece| string += char_for(piece) }
    string
  end

  private

  def board_copy
    Marshal.load(Marshal.dump(self))
  end

  def move_piece(coords, move)
    board[move] = board[coords]
    board[coords] = :empty
  end

  def enemy(color)
    color == :white ? :black : :white
  end

  def king_coords(color)
    board.key(King.new(color))
  end

  def moves(color, moves = [])
    pieces_coords(color).each do |coord|
      moves += board[coord].potential_moves(coord, self)
    end
    moves
  end

  def valid_moves(color, moves = [])
    pieces_coords(color).each do |coord|
      moves += board[coord].moves(coord, self)
    end
    moves
  end

  def no_moves?(color)
    valid_moves(color).length.zero?
  end

  def pieces_coords(color)
    board.select { |_position, piece| piece.is_a?(Piece) && piece.color == color }.keys
  end

  def pieces(color)
    board.select { |_position, piece| piece.is_a?(Piece) && piece.color == color }.values
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
    square_color(board.key(Bishop.new(:white))) == square_color(board.key(Bishop.new(:black)))
  end

  def char_for(piece)
    char = piece_char(piece)
    if piece.is_a?(Piece) && piece.color == :white?
      char.upcase
    else
      char
    end
  end

  def piece_char(piece)
    if piece.is_a?(Pawn)
      'p'
    elsif piece.is_a?(Knight)
      'n'
    elsif piece.is_a?(Bishop)
      'b'
    elsif piece.is_a?(Rook)
      'r'
    elsif piece.is_a?(Queen)
      'q'
    elsif piece.is_a?(King)
      'k'
    else
      ' '
    end
  end
end
