class Draughts_playground

	attr_accessor :table, :preselected_cases, :selected_case, :possibles_moves
	
	def initialize(player_color)
		init_table()
		@preselected_cases = []
		@selected_case = 0
		@possibles_moves = []
		@player_color = player_color
	end
	
	def define_possibles_moves_cases(case_number)	
		@possibles_moves = []
		@possibles_moves = get_capture_cases(case_number, @player_color)	
		if(@possibles_moves.length == 0)
			@possibles_moves = get_possibles_moves(case_number)
		end
		@selected_case = case_number;
	end
	
	# player_color must be b or w (black or white)
	def define_preselected_cases()
		@preselected_cases = []
		cases_to_add = []
		get_cases_number_by_color(@player_color).each do |c|
			cases_to_add = get_capture_cases(c, @player_color)
			if(cases_to_add.length > 0)
				preselected_cases << c
			end
		end
		if(preselected_cases.length == 0)
			get_cases_number_by_color(@player_color).each do |c|
				cases_to_add = get_cases(c, @player_color)
				if(cases_to_add.length > 0)
					preselected_cases << cases_to_add
				end
			end
		end		
	end
	
	def player_move(move)
		add_move(move)		
		ai_play()
		@selected_case = 0
		@possibles_moves = []
		define_preselected_cases()
	end
	
	private
	
		def ai_play()
			moves = []
			ia_color = swicht_color(@player_color)
			cases = get_cases_number_by_color(ia_color)			
			
			cases.each do |c|
				moves_cases = get_capture_cases(c, ia_color)
				moves_cases.each do |m|
					moves << build_move(c, m)
				end
			end
			if(moves.length == 0)
				cases.each do |c|
					moves_cases = get_possibles_moves(c)
					moves_cases.each do |m|
						moves << build_move(c, m)
					end
				end	
			end	
			add_move(choise_better_move(moves))
		end
		
		def choise_better_move(moves)
            # intelligence should be define here
        
            return moves.shuffle.first
        end
		
		# move must be a three char table
		def add_move(move)
			start_case = move[0].to_i
			end_case = move[2].to_i
			if(@table[start_case - 1][0] != '_' && @table[end_case - 1][0] == '_')
				player_char = @table[start_case - 1]
				@table[start_case - 1] = '_'
				@table[end_case - 1] = player_char
				delete_capture_pieces(move, start_case, end_case)  
			end	
		end
	
		def init_table()
			@table = []
			case_string = "b"
			(0..49).each do |pos|
				if(pos == 20)
					case_string = "_"
				end   
				if(pos == 30)
					case_string = "w"
				end
				@table[pos] = case_string
			end
		end

		def get_line_number(case_number)
			return (case_number/5.0).ceil
		end

		def delete_capture_pieces(move, start_case, end_case)
			if(move[1] == 'x')
				capture_line_number = (get_line_number(start_case) + get_line_number(end_case)) / 2
				case_number = 0
				if(capture_line_number%2 != 0)
					case_number = (start_case + end_case - 1)/2
				else 
					case_number = (start_case + end_case + 1)/2
				end
				@table[case_number - 1] = '_'
			end
		end

		def get_cases_number_by_color(color)
			cases = []
			index = 0
			table.each do |c|
				if(c == color)
					cases << (index +1)
				end
				index += 1
			end
			return cases
		end
		
		def get_cases(case_number, color)
			line_number = get_line_number(case_number)
			result = []
			modificator = define_modificator(color)
			if(line_number%2 == 0) 
				add_case_number_to_array(result, case_number -1 + modificator,case_number + modificator, case_number)
			elsif(line_number%2 != 0) 
				add_case_number_to_array(result, case_number + modificator,case_number +1 + modificator, case_number)
			end
			return result
		end 
		
		def define_modificator(color)
			modificator = -5
			if(color == 'b')
				modificator = 5
			end
			return modificator
		end
		
		def add_case_number_to_array(my_array, case_number_first,case_number_second, selected_case)
			last_char = selected_case.to_s.last
			if(@table[case_number_first - 1] == '_' && last_char != '6')
				my_array << selected_case
			elsif(@table[case_number_second - 1] == '_' && last_char != '5')
				my_array << selected_case
			end
			return my_array
		end
		
		def get_possibles_moves(case_number)
			result= []                
			if(case_number > 0)
				actual_case = @table[case_number - 1]            
				color = actual_case[0]
				modificator = define_modificator(color)
#				to_return = check_catch_pieces(color)            
				if(actual_case[0] != '_' && result.length == 0)
					line_number = get_line_number(case_number)
					if(line_number%2 == 0) 
						select_possibles_moves(result, case_number -1 + modificator,case_number + modificator, case_number)
					elsif(line_number%2 != 0) 
						select_possibles_moves(result, case_number + modificator,case_number +1 + modificator, case_number)
					end					
				end
			end
			return result;
		end  
		
		def select_possibles_moves(my_array, case_number_first,case_number_second, selected_case)
			last_char = selected_case.to_s.last
			if(@table[case_number_first - 1] == '_' && last_char != '6')
				my_array << case_number_first
			end
			if(@table[case_number_second - 1] == '_' && last_char != '5')
				my_array << case_number_second
			end
			return my_array
		end
		
		def swicht_color(color)
			if(color == 'b')
				return 'w'
			end
			return 'b'
		end
		
		def build_move(start_case, end_case)
			middle_char = '_'
			if((start_case - end_case).abs > 6)
				middle_char = 'x'
			end
			return [start_case.to_s,middle_char,end_case.to_s]
		end
		
		def get_capture_cases(case_number, color)
			line_number = get_line_number(case_number)
		    moves = []
		    if(line_number%2 == 0) 
		        if(case_number > 9 &&
		            @table[case_number - 1 - 9][0] == '_' && 
		            @table[case_number - 1 - 5][0] != color &&
		            @table[case_number - 1 - 5][0] != '_' &&
		            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
		            moves<< case_number - 9
		        end
		        if(case_number > 10 &&
		            @table[case_number - 1 - 11][0] == '_' && 
		            @table[case_number - 1 - 6][0] != color &&
		            @table[case_number - 1 - 6][0] != '_' && 
		            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
		            moves << case_number - 11
		        end
		        if(case_number < 39 &&
		            @table[case_number - 1 + 11][0] == '_' && 
		            @table[case_number - 1 + 5][0] != color &&
		            @table[case_number - 1 + 5][0] != '_' &&
		            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
		            moves << case_number + 11
		        end
		        if( case_number < 42 &&
		            @table[case_number - 1 + 9][0] == '_' && 
		            @table[case_number - 1 + 4][0] != color &&
		            @table[case_number - 1 + 4][0] != '_' &&
		            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
		            moves << case_number + 9
		        end
		    elsif(line_number%2 != 0)
		        if( case_number > 9 &&
		            @table[case_number - 1 - 9][0] == '_' && 
		            @table[case_number - 1 - 4][0] != color &&
		            @table[case_number - 1 - 4][0] != '_' &&
		            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
		            moves<< case_number - 9
		        end
		        if( case_number > 10 &&
		            @table[case_number - 1 - 11][0] == '_' && 
		            @table[case_number - 1 - 5][0] != color &&
		            @table[case_number - 1 - 5][0] != '_' && 
		            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
		            moves << case_number - 11
		        end
		        if( case_number < 39 &&
		            @table[case_number - 1 + 11][0] == '_' && 
		            @table[case_number - 1 + 6][0] != color &&
		            @table[case_number - 1 + 6][0] != '_' &&
		            case_number.to_s.last != '0' && case_number.to_s.last != '5' )
		            moves << case_number + 11
		        end
		        if( case_number < 42 &&
		            @table[case_number - 1 + 9][0] == '_' && 
		            @table[case_number - 1 + 5][0] != color &&
		            @table[case_number - 1 + 5][0] != '_' &&
		            case_number.to_s.last != '1' && case_number.to_s.last != '6' )
		            moves << case_number + 9
		        end
		    end
		    
		    return moves
		end    
end
