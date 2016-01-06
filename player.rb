class Player
    def make_a_guess
        puts "What is your guess?"
        guess = gets.chomp.split(", ")
        guess.each{ |color| color.strip! }
        guess


    end
end

