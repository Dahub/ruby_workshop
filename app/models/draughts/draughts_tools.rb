class Draughts_tools

    def initialize()
    end
    
    def self.swicht_color(color)
	    if(color.upcase == 'B')
			return 'w'		
		end
		return 'b'
	end
	
    def self.get_line_number(case_number)
        return (case_number/5.0).ceil
    end

    def self.build_move(start_case, end_case)
        middle_char = '?'
        return [start_case.to_s,middle_char,end_case.to_s]
    end

end
