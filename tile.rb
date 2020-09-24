# tile.rb

class Tile
  DELTAS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ].freeze

  attr_reader :pos

    def initialize(board, pos)
        @board, @pos = board, pos
        @revealed, @flagged, @bombed = false, false, false
    end

    def bombed?
        @bombed
    end

    def revealed?
        @revealed
    end

    def flagged?
        @flagged
    end

    def adjacent_bomb_count
        neighbors.select(&:bombed?).count
    end

    def reveal
        return self if flagged? || revealed?
        @revealed = true

        if !bombed? && adjacent_bomb_count == 0
            neighbors.each(&:explore)
        end
        self
    end



    def toggle_flag
        @flagged = !@flagged unless @revealed
    end

end