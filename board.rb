require_relative "card"

class Board
    attr_reader :grid, :size, :n, :card, :newGrid

    def initialize(n)
        @n = n  
        @size = n * n       
        @grid = Array.new(n){Array.new(n, "")}
        @newGrid = Array.new(n){Array.new(n, :+)}
        @card = Card.new(n)
    end

    # Fills the board with a set of shuffled Card pairs
    def populate
        arr = @card.cards_arr
        
        @grid.flatten.each_with_index do |ele, i|
            @grid[i] = arr[i]
        end

        @grid = @grid.each_slice(@n).to_a # convert back to a n-D array
    end

    #  Accepts an array containing a pair of indices in the form 
    #       [row, column] representing a position on the @board
    #  Returns the element of @grid at the given position
    def [](rc_pos)
        row, col = rc_pos
        return @grid[row][col]
    end

    #  Accepts a position and value as args
    #  Sets the given position of @newGrid to the given value
    def []=(pos, val)
        row, col = pos # pos = [1,2] then row = 1, col = 2
        return @newGrid[row][col] =  val 
    end

    # Reveals a Card at guessed_pos (unless it's already face-up, in 
    # which case the method should do nothing). 
    def reveal(pos)
        row, col = pos 
        self[pos]=self[pos] # @newGrid[row][col] = @grid[row][col]
        system "clear"
        render()
    end

    # Checks if the 2 guesses match
    def match?(guessed)
        g1r, g1c = guessed[0]
        g2r, g2c = guessed[1]

        if !(@newGrid[g1r][g1c] == @newGrid[g2r][g2c])
            @newGrid[g1r][g1c] = :-
            @newGrid[g2r][g2c] = :-
            sleep(1)
            system "clear"
            return false
        end

        render()
        system "clear"
        return true
    end

    # Returns true if all cards have been revealed.
    def won?
        @newGrid.each_with_index do |subArr, idx1|
            subArr.each_with_index do |ele, idx2|
                if ele == :+ || ele == :-
                    return false 
                end
            end
        end
        render()
        puts
        puts "YOU WIN!"
        return true
    end

    # Prints out a representation of the Board's current state
    def render(grid = @newGrid)
        puts
        # cols index
        print "   "
        grid.each_with_index { |ele, i| print " #{i}" }

        puts
        # rows index
        i = 0
        grid.each do |row|
            print "  #{i} " 
            i += 1
            puts row.join(" ")  
        end
    end

    # Prints out a preview of the solution 
    def preview_soln
        render(@grid)
        puts
        i = 5
        while i >= 1
            puts "  Game Starts in #{i}"
            sleep(1)
            i -= 1
        end
        system "clear"
    end

end
