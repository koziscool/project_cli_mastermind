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
        ret_string =  "The guess: #{row.to_s} \n"
        if @response
            response_string = "full matches: #{response[:full_matches]}, color matches: #{response[:color_matches]}, misses #{response[:misses]}"
            ret_string << "Simon says, #{response_string}"
        end
        ret_string
    end
end