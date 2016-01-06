


class Player
    def make_a_guess
        guess_string_arr = []
        puts "Guess #{Row::NUM_PEGS} colors, choices are yellow green purple orange blue brown" 
        
        ( 1..Row::NUM_PEGS ).each do | row_index |
            loop do
                input = CLI.ask "What is your guess, for color #{row_index}?"
                case input.downcase
                when /yellow/
                    guess_string_arr << "yellow"
                    break
                when /green/
                    guess_string_arr << "green"
                    break
                when /purple/
                    guess_string_arr << "purple"
                    break
                when /orange/
                    guess_string_arr << "orange"
                    break
                when /blue/
                    guess_string_arr << "blue"
                    break
                when /brown/
                    guess_string_arr << "brown"
                    break
                else
                    puts "need valid input, try again"
                    next
                end
            end
        end

        guess_string_arr
    end
end