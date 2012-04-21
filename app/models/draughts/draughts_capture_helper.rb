class Draughts_capture_helper

    def initialize()
    end
    
    def self.get_capture_cases_for_queen(case_number, color, table)
        moves = []
        directions = Draughts_direction_helper.get_all_traject_for_queen_without_stop(case_number)
        directions.each do |d|
            store = false
            d.each do |test_case|                
                if(store == true && table[test_case - 1] == '_')
                    moves << test_case
                elsif(store == true && (table[test_case -1] == nil || table[test_case - 1] != '_'))
                    break                    
                end
                if(table[test_case - 1] != '_' && table[test_case - 1].upcase != color.upcase)
                    store = true
                end
           end
        end
        return moves
    end
    
    def self.get_capture_cases_for_pieces(case_number, color, table)
	    moves = []
	    line_number = Draughts_tools.get_line_number(case_number)
	    if(line_number%2 == 0) 
	        if(case_number > 9 &&
	            table[case_number - 1 - 9][0] == '_' && 
	            table[case_number - 1 - 5][0].upcase != color.upcase &&
	            table[case_number - 1 - 5][0] != '_' &&
	            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
	            moves<< case_number - 9
	        end
	        if(case_number > 10 &&
	            table[case_number - 1 - 11][0] == '_' && 
	            table[case_number - 1 - 6][0].upcase != color.upcase &&
	            table[case_number - 1 - 6][0] != '_' && 
	            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
	            moves << case_number - 11
	        end
	        if(case_number < 39 &&
	            table[case_number - 1 + 11][0] == '_' && 
	            table[case_number - 1 + 5][0].upcase != color.upcase &&
	            table[case_number - 1 + 5][0] != '_' &&
	            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
	            moves << case_number + 11
	        end
	        if( case_number < 42 &&
	            table[case_number - 1 + 9][0] == '_' && 
	            table[case_number - 1 + 4][0].upcase != color.upcase &&
	            table[case_number - 1 + 4][0] != '_' &&
	            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
	            moves << case_number + 9
	        end
	    elsif(line_number%2 != 0)
	        if( case_number > 9 &&
	            table[case_number - 1 - 9][0] == '_' && 
	            table[case_number - 1 - 4][0].upcase != color.upcase &&
	            table[case_number - 1 - 4][0] != '_' &&
	            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
	            moves<< case_number - 9
	        end
	        if( case_number > 10 &&
	            table[case_number - 1 - 11][0] == '_' && 
	            table[case_number - 1 - 5][0].upcase != color.upcase &&
	            table[case_number - 1 - 5][0] != '_' && 
	            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
	            moves << case_number - 11
	        end
	        if( case_number < 39 &&
	            table[case_number - 1 + 11][0] == '_' && 
	            table[case_number - 1 + 6][0].upcase != color.upcase &&
	            table[case_number - 1 + 6][0] != '_' &&
	            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
	            moves << case_number + 11
	        end
	        if( case_number < 42 &&
	            table[case_number - 1 + 9][0] == '_' && 
	            table[case_number - 1 + 5][0].upcase != color.upcase &&
	            table[case_number - 1 + 5][0] != '_' &&
	            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
	            moves << case_number + 9
	        end
	    end
	    
	    return moves
	end	
    
end
