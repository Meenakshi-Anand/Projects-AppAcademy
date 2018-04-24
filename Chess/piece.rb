class Piece
attr_reader :name
  # def initialize(position, name)
  #   @name = name
  #   @position = position
  # end

  def moves

  end

end


module SlidingPiece

  def move_dirs

  end
end

module SteppingPiece

end

require 'singleton'
class NullPiece < Piece

  def initialize

  end
end
