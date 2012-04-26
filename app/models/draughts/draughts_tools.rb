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
    
    def self.define_game_state(table, player_color)
        game_state = 'draw'
	    player_pieces = table.select { |p| p.upcase == player_color.upcase }
	    ai_pieces = table.select { |p| p.upcase == swicht_color(player_color).upcase }
	    if(player_pieces.length == 0)		        
	        game_state = 'ai'
	    elsif(ai_pieces.length == 0)
	        game_state = 'player'	   
	    end
	    return game_state
	end

end
