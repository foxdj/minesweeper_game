# board.rb

class Board
    def self.empty_grid
        Array.new(9) do
            Array.new(9) { Tile.new("*") }
        end
    end

    def initialize(grid = self.empty_grid)
        @grid = grid
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def []=(pos, value)
        x, y = pos
        tile = grid[x][y]
        tile.value = value
    end

    def render

    end

    def solved?

    end


end