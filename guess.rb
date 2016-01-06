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