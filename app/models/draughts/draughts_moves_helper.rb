class Draughts_moves_helper  
    
    def self.get_cases_number_by_color(color, table)
		cases = []
		index = 0
		table.each do |c|
			if(c.upcase == color.upcase)
				cases << (index +1)
			end
			index += 1
		end
		return cases
	end
	
	def self.add_move(move, table)
		if(move != nil)
			start_case = move[0].to_i
			end_case = move[2].to_i
			if(table[start_case - 1][0] != '_' && table[end_case - 1][0] == '_')
				player_char = table[start_case - 1]
				table[start_case - 1] = '_'
				table[end_case - 1] = player_char
				delete_capture_pieces(move, start_case, end_case, table)  				
			end	
		end		
		return move
	end
	
	def self.get_possibles_moves(case_number, table)
		result= []                
		if(case_number > 0)
			actual_case = table[case_number - 1]
			color = actual_case[0]
			if(color == 'W' || color == 'B')
				result = get_possibles_moves_for_queen(case_number,color, table)
			else
				result = get_possibles_moves_for_pieces(case_number,color, table)
			end	
		end
		return result;
	end  	
	
	def self.check_promote_piece(move, color, table)
		line_number = Draughts_tools.get_line_number(move[2].to_i)
		if(color == 'w' && line_number == 1)
			table[move[2].to_i - 1 ] = 'W'
		elsif(color == 'b' && line_number == 10)
			table[move[2].to_i - 1 ] = 'B'
		end
	end

	def self.define_if_move_is_capture(move, table)	
		if(move != nil)		
			start_case = move[0].to_i
			end_case = move[2].to_i
			capture_color = Draughts_tools.swicht_color(table[start_case -1])
			move_direction = Draughts_direction_helper.define_move_direction(move) # shoul be NO NE SO or SE			
			traject_cases = Draughts_direction_helper.get_moves_for_one_direct(move_direction, start_case, end_case)	
			traject_cases.each do |c|
				if(table[c - 1].upcase == capture_color.upcase)
					move[1] = 'x'
					break
				end
			end
		end
		return move
	end	

	private
		
        def self.delete_capture_pieces(move, start_case, end_case, table)
            if(move[1] == 'x')
                direction = Draughts_direction_helper.define_move_direction(move)
                cases = Draughts_direction_helper.get_moves_for_one_direct(direction,start_case,end_case)
                cases.each do |c|
	                table[c - 1] = '_'
                end
            end
        end
        
        def self.get_possibles_moves_for_queen(case_number,color, table)
			result = []
			Draughts_direction_helper.get_all_traject_for_queen(case_number, table).each do |moves|
				result.concat(moves)
			end			
			return result				
		end
		
		def self.get_possibles_moves_for_pieces(case_number,color, table)
			result = []
			modificator = define_modificator(color)
			line_number = Draughts_tools.get_line_number(case_number)
			if(line_number%2 == 0) 
				select_possibles_moves(result, case_number -1 + modificator,case_number + modificator, case_number, table)
			elsif(line_number%2 != 0) 
				select_possibles_moves(result, case_number + modificator,case_number +1 + modificator, case_number, table)
			end					
			return result
		end
		
		def self.select_possibles_moves(my_array, case_number_first,case_number_second, selected_case, table)
			last_char = selected_case.to_s.last
			if(table[case_number_first - 1] == '_' && last_char != '6')
				my_array << case_number_first
			end
			if(table[case_number_second - 1] == '_' && last_char != '5')
				my_array << case_number_second
			end
			return my_array
		end	

		def self.define_modificator(color)
			modificator = -5
			if(color.upcase == 'B')
				modificator = 5
			end
			return modificator
		end
end
