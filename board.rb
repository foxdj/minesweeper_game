# board.rb
require_relative 'tile'

class Board
    attr_reader :grid_size, :num_bombs

    def initialize(grid_size, num_bombs)
        @grid_size, @num_bombs = grid_size, num_bombs
        generate_board
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def lost?
        @grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
    end

    def won?
        @grid.flatten.all? { |tile| tile.bombed? != tile.revealed? }
    end

    def render(game_over = false)
        @grid.map do |row|
            row.map do |tile|
                game_over ? tile.full_reveal : tile.render
            end.join("")
        end.join("\n")
    end

    def game_over
        render(true)
    end

    private

    


end