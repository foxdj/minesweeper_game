# minesweeper.rb
require 'yaml'
require_relative 'board'

class MinesweeperGame
    LAYOUTS = {
        small: { grid_size: 9, num_bombs: 10 },
        medium: { grid_size: 16, num_bombs: 40 },
        large: { grid_size: 32, num_bombs: 160 }
    }.freeze

    def initialize(size)
        layout = LAYOUTS[size]
        @board = Board.new(layout[:grid_size], layout[:num_bombs])
    end

    def play
        take_turn until solved?
        puts "Congrats, you win!"
    end

    def take_turn
        pos = get_pos
        action = get_action

    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Enter a position within the board (e.g. '1,3')"
            print ">"

            begin
                pos = parse_pos(gets.chomp)
            rescue
                puts "Invalid position"
                print ""
                pos = nil
            end
        end

        pos
    end

    def get_action
        action = nil
        until action && valid_action?(action)
            available_actions
            action = gets.chomp
        end
    end

    def available_actions
        puts "Enter an action:"
        puts "For reveal, type 'r'"
        puts "For flag, type 'f'"
        print ">"
    end

    def parse_pos(string)
        string.split(",").map { |char| Integer(char) }
    end

    def solved?
        board.solved?
    end

    def valid_pos?(pos)

    end

    def valid_action?(action)

    end


end

if $PROGRAM_NAME == __FILE__
  case ARGV.count
  when 0
    MinesweeperGame.new(:small).play
  when 1
    # resume game, using first argument
    YAML.load_file(ARGV.shift).play
  end
end