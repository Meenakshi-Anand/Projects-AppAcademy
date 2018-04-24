class Piece
attr_reader :color,:board,:position

  def initialize(color,board,position)
    @color = color
    @board = board
    @position = position
  end


end

HV_MOVE = [[0,1], [0,-1], [-1,0], [1,0]]
D_MOVE = [[1,1],[-1,-1],[1,-1],[-1,1]]

module Slideable

  def horizontal_dirs
  HV_MOVE
  end

  def diagonal_dirs
  D_MOVE
  end

  def moves
    start_pos = self.position
    ans = []
    array = move_dirs
    array.each do |move|
      new_x, new_y = move[0]+start_pos[0], move[1]+start_pos[1]
      if [new_x, new_y].all? {|x| x.between?(0,7)}
        ans << grow_unblocked_moves_in_dir(new_x, new_y)
      end
    end
    ans
  end

  def move_dirs
  raise "Undefined Method"
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    ans = []
    start_pos = self.position
    start_x, start_y = start_pos
    direction = [dx - start_x, dy - start_y]
    until true
      new_pos_x = start_x +  direction[0]
      new_pos_y = start_y +  direction[1]
      pos = [new_pos_x,new_pos_y]
      piece = board[pos]
      if piece.class.is_a?(NullPiece)
        ans << pos
      elsif piece.color == board[start_x,start_y].color
        break
      else
        ans << pos
        break
      end
      start_x, start_y = new_x, new_y
    end
    ans
  end


end


module SteppingPiece

  def horizontal_dirs
  HV_MOVE
  end

  def diagonal_dirs
  D_MOVE
  end

  def moves
    start_pos = self.position
    ans = []
    array = move_dirs
    array.each do |move|
      new_x, new_y = move[0]+start_pos[0], move[1]+start_pos[1]
      if [new_x, new_y].all? {|x| x.between?(0,7)}
        ans << [new_x, new_y] if valid_move?([new_x, new_y])
      end
    end
    ans
  end

  def valid_move?(pos)
    if piece.class.is_a?(NullPiece)
      return true
    elsif piece.color != board[start_x,start_y].color
      return true
    end
    return false
  end

end

require 'singleton'
class NullPiece < Piece

  def initialize

  end
end
