class Draughts_moves_helper  
    
    BLACK_MOVES_ARRAY = [   [1,[6,7]],[2,[7,8]],[3,[8,9]],[4,[9,10]],[5,[10]],
                            [6,[11]],[7,[11,12]],[8,[12,13]],[9,[13,14]],[10,[14,15]],
                            [11,[16,17]],[12,[17,18]],[13,[18,19]],[14,[19,20]],[15,[20]],
                            [16,[21]],[17,[21,22]],[18,[22,23]],[19,[23,24]],[20,[24,25]],
                            [21,[26,27]],[22,[27,28]],[23,[28,29]],[24,[29,30]],[25,[30]],
                            [26,[31]],[27,[31,32]],[28,[32,33]],[29,[33,34]],[30,[34,35]],
                            [31,[36,37]],[32,[37,38]],[33,[38,39]],[34,[39,40]],[35,[40]],
                            [36,[41]],[37,[41,42]],[38,[42,43]],[39,[43,44]],[40,[44,45]],
                            [41,[46,47]],[42,[47,48]],[43,[48,49]],[44,[49,50]],[45,[50]]]
    
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
			move_direction = Draughts_direction_helper.define_move_direction(move) # should be NO NE SO or SE			
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
		    
		    if(color == 'b') # optimisation for ia	    
		        BLACK_MOVES_ARRAY.select { |c| c[0] == case_number }.first[1].each do |m|
		            if(table[m -1] == '_')
		                result << m		                
		            end
		        end		        
		    else
			    modificator = define_modificator(color)
			    line_number = Draughts_tools.get_line_number(case_number)
			    if(line_number%2 == 0) 
				    select_possibles_moves(result, case_number -1 + modificator,case_number + modificator, case_number, table)
			    elsif(line_number%2 != 0) 
				    select_possibles_moves(result, case_number + modificator,case_number +1 + modificator, case_number, table)
			    end	
			end
			return result
		end
		
#		def self.get_possibles_moves_for_pieces(case_number,color, table)
#			result = []
#			modificator = define_modificator(color)
#			line_number = Draughts_tools.get_line_number(case_number)
#			if(line_number%2 == 0) 
#				select_possibles_moves(result, case_number -1 + modificator,case_number + modificator, case_number, table)
#			elsif(line_number%2 != 0) 
#				select_possibles_moves(result, case_number + modificator,case_number +1 + modificator, case_number, table)
#			end					
#			return result
#		end
		
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
