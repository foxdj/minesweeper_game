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
        until @board.lost? || @board.won?
            @board.render
            take_turn
        end

        if @board.won?
            puts "Congrats, you win!"
        elsif @board.lost?
            puts "*** Bomb hit! ***"
            @board.game_over
        end
    end

    def take_turn
        pos = get_pos
        action = get_action
        perform_turn(pos, action)
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
        puts "To reveal, type 'r'"
        puts "To flag, type 'f'"
        puts "To save, type 's'"
        print ">"
    end

    def parse_pos(string)
        string.split(",").map { |char| Integer(char) }
    end

    private

    def valid_pos?(pos)
        pos.length == 2 &&

    end

    def valid_action?(action)
        valid_actions = ['r', 'R', 'f', 'F', 's', 'S']
        valid_actions.include?(action)
    end

    def perform_turn(pos, action)
        tile = @board[pos]

        case action
        when 'f' || 'F'
            tile.toggle_flag
        when 'r' || 'R'
            tile.reveal
        when 's' || 'S'
            save
        end
    end

    def save
        puts "Enter filename to save at:"
        filename = gets.chomp

        File.write(filename, YAML.dump(self))
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