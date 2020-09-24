# tile.rb

class Tile
    def initialize(symbol)
        @symbol = symbol
        @revealed = false
        @flagged = false
        @bomb = false
    end

    def reveal
        if !@revealed
            @revealed = true
        else
            puts "Tile already revealed"
        end
    end

    def flag
        @flagged ? @flagged = false : @flagged = true
    end

    

end