
require "highline"
CLI = HighLine.new

require "./peg"
require "./row"
require "./board"
require "./player"
require "./guess"


class Mastermind

    def initialize
        @board = Board.new
        @master = Player.new
        @guesser = Player.new
    end

    def instructions
        # puts "make a guess"
        # puts "if incorrect, make another"
    end

    def play
        instructions
        @board.create_autogenerate_solution

        num_guesses = 0
        while num_guesses < 15 do
            @board.add_guess_row( @guesser.make_a_guess )

            # puts
            # puts @board.guesses.last.to_s 

            respond_to_guess

            # puts
            # puts  "#{@board.solution_row.to_s}"
            num_guesses += 1
            puts "Guess ##{num_guesses}"
            puts @board.guesses.last.to_s
            puts

            if win?
                puts "you win, congratulations"
                break
            end
        end
    end

    def win?
        @board.guesses.last == @board.solution_row
    end

    def respond_to_guess
        guess_row = @board.guesses.last.row.slots
        solution_row = @board.solution_row.slots

        remainder_guess = Hash.new(0)
        remainder_solution = Hash.new(0)

        full_matches = 0
        ( 0...Row::NUM_PEGS ).each do |index|
            if guess_row[index].color == solution_row[index].color
                full_matches += 1
            else
                remainder_guess[ guess_row[index].color ] += 1
                remainder_solution[ solution_row[index].color ] += 1
            end
        end

        color_matches = 0
        remainder_guess.each do | color, color_multiplicity |
            color_matches += [ remainder_solution[color], color_multiplicity ].min
        end

        misses = Row::NUM_PEGS - full_matches - color_matches
        response = { full_matches: full_matches, color_matches: color_matches, misses: misses }
        @board.guesses.last.response = response
        response
    end
end




test_game = Mastermind.new
test_game.play





