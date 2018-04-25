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
    initial_pos = [1,0,7,6]
    grid.each_with_index do |row,id|
      if initial_pos.include?(id)
        row.each_index do |idx|
           row[idx] =Pawn.new(1,self,[id,idx]) if id == 1
           row[idx] =Pawn.new(0,self,[id,idx]) if id == 6
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

  def in_check?(color)
    location = find_king_location(color)
    opp_color = (color == 1) ? 0 : 1
    moves = opp_moves(opp_color)
    moves.include?(location)
  end

  def check_mate(color)
    if in_check?(color)
      pos_moves = self[find_king_location(color)].moves
      pos_moves.all? {|pos| pos_check?(pos,color)}
    else
      return false
    end
  end

  def pos_check?(pos,color)
    opp_color = (color == 1) ? 0 : 1
    opp_moves(opp_color).include?(pos)
  end

  def opp_moves(opp_color)
    ans = []
    grid.each_with_index do |row,rowid|
      row.each_with_index do |el,elid|
        if el.color == opp_color
          el_moves = el.moves
          ans += el_moves
        end
      end
    end
    ans
  end


  def find_king_location(color)
    grid.each_with_index do |row, rowid|
      row.each_with_index do |el, elid|
        return [rowid, elid] if el.class == King && el.color == color
      end
    end

  end

  def move_piece(start_pos,end_pos)
    raise "There is nothing here" if self[start_pos].is_a?(NullPiece)
    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
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
  # byebug

  board.move_piece([6,2],[5,2])
  board.move_piece([1,2],[2,2])
  board.move_piece([7,2],[5,0])
  board.move_piece([5,0],[4,1])
  board.move_piece([4,1],[3,0])
  display = Display.new(board)
  display.try
p board.in_check?(1)

display.try
p board.check_mate(1)
end
