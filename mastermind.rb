

class Peg
    COLORS = [ "yellow", "green", "purple", "orange", "blue", "brown"]
    attr_accessor :color
    def initialize (color)
        @color = color
    end
end

######

class Row 
    NUM_PEGS = 4
    attr_accessor :slots
    def initialize
        @slots = []
    end

    def populate_row ( colors )
        colors.each do | color |
            @slots << Peg.new( color )
        end
    end

    def to_s
        colors = @slots.map { |slot| slot.color }
        colors.join(", ")
        puts colors
    end
end

#########

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

##########

class Guess
    attr_accessor :response, :row
    def initialize ( row )
        @row = row
    end

    def populate_repsonse
        @response = response
    end

    def display_response
        puts " full matches: #{@response[:full_matches]}, 
                    color matches: #{@response[:color_matches]}, 
                    misses: #{@response[:misses]}}"
    end

    def to_s
        row.to_s
        response.to_s
    end
end

###########

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

#########

class Player
  def make_a_guess
    puts "What is your guess?"
    guess = gets.chomp.split(", ")
    guess.each{ |color| color.strip! }
    guess
  end
end

class Human < Player
  def make_a_guess
    puts "What is your guess?"
    guess = gets.chomp.split(",")
    guess.each{ |color| color.strip! }
    guess
  end
end

class Computer < Player
  def make_a_guess
  end
end

##############


test_game = Mastermind.new
test_game.play

# test_board = Board.new
# test_board.create_autogenerate_solution()
# puts test_board.solution_row.to_s
# test_board.add_guess_row(Row.new.populate_row(["yellow", "blue", "orange", "green"]))
# puts test_board.guesses.last.to_s

# the_mind = Mastermind.new
# the_mind.play


