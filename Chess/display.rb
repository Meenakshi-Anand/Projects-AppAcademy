require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'
require_relative 'piece.rb'
class Display

attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    i = 0
    board.grid.each_with_index do |row,ri|
      j = (i.even?)? 0:1
      row.each_with_index do |box,bi|
        # bcolor = (j.even?)? :black : :white
        if @cursor.cursor_pos == [ri,bi]
          print "#{box.symbol.colorize(background: :red)}" #+ "|"
        else
            print "#{box.symbol.colorize(background: (j.even?)?
            :grey : :white)}" #+ "|"
        end
        j += 1
      end
      print "\n"
      i += 1
    end
  end

  def try
    #  while true
    system("clear")
      render
      # cursor.get_input
    # end
  end

end

if __FILE__ == $PROGRAM_NAME
board = Board.new
# debugger
display = Display.new(board)
inp1 = nil
inp2 = nil
# cursor = Cursor.new([0,0], board)
  while true
    display.try
    inp = display.cursor.get_input
    if inp == nil
      next
    else
      if inp1.nil?
        inp1 = inp
      else
        inp2 = inp
      end
    end
    if [inp1,inp2].none? { |x| x.nil? }
      p [inp1, inp2]
      board.move_piece(inp1,inp2)
      inp1 = inp2 = nil
    end
  end
# p input_pos
# end_pos = Cursor.get_input
# board.move_piece(initial_pos, end_pos)
# display = Display.new(board)
# display.try
end
