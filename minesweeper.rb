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

    def solved?
        board.solved?
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