require_relative 'piece.rb'
require 'singleton'
require 'byebug'
class Piece
attr_reader :color,:board
attr_accessor :position

  def initialize(color,board,position)
    @color = color
    @board = board
    @position = position
  end

end

class NullPiece < Piece
 include Singleton
   def initialize
     super(nil, board, position)
   end

   def symbol
     "   "
   end
end

class King < Piece

  include Steppable
  def symbol
    [" ♔ " , " ♚ " ][color]
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end

class Queen < Piece
include Slideable
  def symbol
    [" ♕ "," ♛ "][color]
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end

class Rook < Piece
include Slideable
  def symbol
    [" ♖ "," ♜ "][color]
  end

  def move_dirs
    horizontal_dirs
  end

end

class Bishop < Piece
  include Slideable
  def symbol
    [" ♗ "," ♝ "][color].to_s
  end

  def move_dirs
    diagonal_dirs
  end
end

class Knight < Piece
  include Steppable
  def symbol
    [" ♘ "," ♞ "][color].to_s
  end

  def move_dirs
    [[1,2], [2,1], [-1,-2], [-2,-1], [-1,2], [2,-1], [1,-2],[-2,1]]
  end

end

class Pawn < Piece
  def symbol
    [" ♙ "," ♟ "][color]
  end
  # def move_dirs
  #
  # end

  def moves
    pos = self.position
    # debugger
    moves = []
    if self.color == 0
      moves << [pos[0]+1, pos[1]] unless pos[0]+1 > 7
    elsif self.color == 1
      moves << [pos[0]-1, pos[1]] unless pos[0]-1 < 0
    end
    moves
  end
end
