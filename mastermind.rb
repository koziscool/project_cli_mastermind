
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
        puts "make a guess"
        puts "if incorrect, make another"
    end

    def play
        instructions
        @board.create_autogenerate_solution
        @board.add_guess_row( @guesser.make_a_guess )

        @board.guesses.each { |guess| puts guess }
        respond_to_guess
        @board.solution_row.to_s
        @board.guesses.each { |guess| puts guess }

    end

    def check_win?
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





