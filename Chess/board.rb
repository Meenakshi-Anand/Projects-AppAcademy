require_relative "piece.rb"

class Board

  attr_reader :grid


  def initialize
  @grid = Array.new(8){Array.new(8)}
  populate
  end

  def populate
    initial_pos = [0,1,6,7]
    grid.each_with_index do |row,id|
      if initial_pos.include?(id)
        row.each_index {|idx|row[idx] =Piece.new }
      else
        row.each_index {|idx|row[idx] =NullPiece.new }
      end
    end
  end

  def move_piece(start_pos,end_pos)
    raise "There is nothing here" if self[start_pos].is_a?(NullPiece)
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.new
  end

  def []=(position,value)
    x,y= position
    grid[x][y]=value
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def valid_pos?(pos)
    pos.all? {|n| n>=0 && n<8}
  end



end
