require_relative 'piece.rb'
require_relative 'army.rb'
require_relative 'display.rb'
require 'byebug'

class Board

  attr_reader :grid


  def initialize
  @grid = Array.new(8){Array.new(8)}
  populate
  end

  def populate
    initial_pos = [0,7]
    grid.each_with_index do |row,id|
      if initial_pos.include?(id)
        row.each_index do |idx|
           #row[idx] =Pawn.new(1,self,[id,idx]) if id == 1
           #row[idx] =Pawn.new(0,self,[id,idx]) if id == 6
          if id == 0
            row[idx] =Rook.new(1,self,[id,idx]) if idx == 0 || idx == 7
            row[idx] =Knight.new(1,self,[id,idx]) if idx == 1 || idx == 6
            row[idx] =Bishop.new(1,self,[id,idx]) if idx == 2 || idx == 5
            row[idx] =King.new(1,self,[id,idx]) if idx == 3
            row[idx] =Queen.new(1,self,[id,idx]) if idx == 4
          elsif id == 7
            row[idx] =Rook.new(0,self,[id,idx]) if idx == 0 || idx == 7
            row[idx] =Knight.new(0,self,[id,idx]) if idx == 1 || idx == 6
            row[idx] =Bishop.new(0,self,[id,idx]) if idx == 2 || idx == 5
            row[idx] =King.new(0,self,[id,idx]) if idx == 4
            row[idx] =Queen.new(0,self,[id,idx]) if idx == 3
          end
        end
      else
        row.each_index {|idx|row[idx] = NullPiece.instance() }
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

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  p board[[0,4]].moves
end
