require_relative 'piece.rb'

class King < Piece

include 'Steppable'
  def symbol
    [♚, ♔]
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end

class Queen < Piece
include 'Slideable'
  def symbol
    [♕,♛][color]
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end

end

class Rook < Piece
include 'Slideable'
  def symbol
    [♖,♜][color]
  end

  def move_dirs
    horizontal_dirs
  end

end

class Bishop < Piece
  include 'Slideable'
  def symbol
    [♗,♝][color]
  end

  def move_dirs
    diagonal_dirs
  end
end

class Knight < Piece
  include 'Steppable'
  def symbol
    [♘,♞][color]
  end

  def move_dirs
    [1,2], [2,1], [-1,-2], [-2,-1], [-1,2], [2,-1], [1,-2],[-2,1]
  end

end

class Pawn < Piece
  def symbol
    [♙,♟][color]
  end
  def move_dirs
  end
end
