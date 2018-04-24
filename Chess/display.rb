require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'
class Display

attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.grid.each_with_index do |row,ri|
      row.each_with_index do |box,bi|
        if @cursor.cursor_pos == [ri,bi]
          print "#{box.class.to_s.colorize(:red)}" + " |"
        else
            print "#{box.class}" + " |"
        end
      end
      print "\n"
      puts "------------------------------------------"
    end
  end

  def try
    while true
      render
      cursor.get_input
    end
  end

end

if __FILE__ == $PROGRAM_NAME
board = Board.new
display = Display.new(board)
display.try

end
