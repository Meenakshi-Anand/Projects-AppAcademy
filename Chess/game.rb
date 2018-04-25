
require 'colorize'
require_relative 'cursor.rb'
require_relative 'board.rb'
require_relative 'piece.rb'
if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  inp1 = nil
  inp2 = nil



  puts("Enter 1st name: ")
  name1 = gets.chomp
  puts("Enter 2nd name: ")
  name2 = gets.chomp



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
        # p [inp1, inp2]
        board.move_piece(inp1,inp2)
        inp1 = inp2 = nil
      end
      puts "#{name1} you got a check" if board.in_check?(1)
       if board.check_mate(1)
         puts "#{name1} you got a checkmate"
         puts "Game Over"
         break
       end
       puts "#{name2} you got a check" if board.in_check?(0)
        if board.check_mate(0)
          puts "#{name2} you got a checkmate"
          puts "Game Over"
          break
        end
    end
  end
