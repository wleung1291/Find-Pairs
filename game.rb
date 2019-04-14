require_relative "board"
        
class Game 
    system "clear"
    input = ""
    until input == 0 || input == 1 || input == 2 || input == 3
        print "Choose difficulty (1 - Easy, 2 - Medium, 3 - Hard): "  
        input = gets.chomp.to_i
        if input == 0 #test
            difficulty = 2
        elsif input == 1
            difficulty = 4
        elsif input == 2
            difficulty = 6
        elsif input == 3
            difficulty = 8
        end
    end

    board = Board.new(difficulty)
    board.populate
    guess_arr = []
    matching_pairs = []

    if __FILE__ == $PROGRAM_NAME
        board.preview_soln()
        
        until board.won?
            guesses = 0
            prev_guess = []
            guess_arr = []
            board.render()

            until guesses == 2
                puts
                puts "Enter a position(from 0 to #{board.n - 1}) with a space (e.g., `1 0`)"
                print "> "
                str = gets.chomp.split(" ")
                str.map! { |ele| ele.to_i }

                # Checks if the 2 guesses are not the same and if the current
                # guess is not an already correctly guessed pair position
                if prev_guess != str && !matching_pairs.include?(str)
                    prev_guess = str
                    guess_arr << str
                    board.reveal(str)
                    guesses += 1
                    str = []
                else 
                    puts "Try a different position"
                end
            end

            # tracks the positions of guessed matching pairs
            if board.match?(guess_arr) 
                system "clear"
                guess_arr.each do |subArr|
                    matching_pairs << subArr
                end
            end
        end
    end

end
