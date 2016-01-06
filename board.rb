class Board
    attr_accessor :solution_row, :guesses
    def initialize
        @solution_row = Row.new
        @guesses = []
    end

    def create_solution ( solution )
        @solution_row.populate_row ( solution )
    end

    def create_autogenerate_solution 
        solution = []
        Row::NUM_PEGS.times do
            solution << Peg::COLORS.sample
        end
        create_solution( solution )
    end

    def add_guess_row( guess_string_arr )   # guess is an array of strings here
        guess_row = Row.new
        guess_row.populate_row( guess_string_arr )
        new_guess = Guess.new ( guess_row )
        @guesses << new_guess
    end

    def to_s
        @guesses.each { | guess |  guess.row.to_s }
    end
end