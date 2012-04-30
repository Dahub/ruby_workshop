class Draughts_playground

	attr_accessor   :table, :preselected_cases, 
	                :selected_case, :possibles_moves, :game_state, :player_color 
	
	def initialize(player_color)
		init_table()
		@preselected_cases = []
		@selected_case = 0
		@possibles_moves = []
		@player_color = player_color
		@game_state = 'none'
	end

	def clone()
	    my_playground = Draughts_playground.new(@player_color)            
        my_playground.table = @table.clone()
        return my_playground
	end
	
	def define_possibles_moves_cases(case_number)	
		@possibles_moves = []
		@possibles_moves = Draughts_capture_helper.get_capture_cases(case_number, @player_color, table)		
		if(@possibles_moves.length == 0)
			@possibles_moves = Draughts_moves_helper.get_possibles_moves(case_number,@table)
		end
		@selected_case = case_number;
	end


	# player_color must be b or w (black or white)
	def define_preselected_cases()
		@preselected_cases = []
		cases_to_add = []
		Draughts_moves_helper.get_cases_number_by_color(@player_color, @table).each do |c|
			cases_to_add = Draughts_capture_helper.get_capture_cases(c, @player_color, table)
			if(cases_to_add != nil && cases_to_add.length > 0)
				preselected_cases << c
			end
		end
		if(preselected_cases.length == 0)
			Draughts_moves_helper.get_cases_number_by_color(@player_color, @table).each do |c|
				cases_to_add = get_cases(c, @player_color)
				if(cases_to_add.length > 0)
					preselected_cases << cases_to_add
				end
				cases_to_add = get_cases_for_queen(c, @player_color)				
				if(cases_to_add.length > 0)
					preselected_cases << cases_to_add
				end
			end
		end		
		if(@preselected_cases.length == 0)
		    @game_state = Draughts_tools.define_game_state(@table,@player_color)
		end
	end
	
	def player_move(move)
		move = Draughts_moves_helper.define_if_move_is_capture(move,table)
		Draughts_moves_helper.add_move(move, table)		
		if(move[1] != 'x' || Draughts_capture_helper.get_capture_cases(move[2].to_i, @player_color, table).length == 0)
			@selected_case = 0
			@possibles_moves = []
			Draughts_moves_helper.check_promote_piece(move, @player_color, @table)	
    		ai_play()
		else			
			@selected_case = move[2].to_i
			@possibles_moves = Draughts_capture_helper.get_capture_cases(move[2].to_i, @player_color, table)
			@preselected_cases = [move[2].to_i]
		end
		define_preselected_cases()
	end
	
	private
	
		def ai_play()
			moves = []
			ia_color = Draughts_tools.swicht_color(@player_color)
			cases = Draughts_moves_helper.get_cases_number_by_color(ia_color, @table)	
			cases.each do |c|
				moves_cases = Draughts_capture_helper.get_capture_cases(c, ia_color, table)
				moves_cases.each do |m|
					moves << Draughts_tools.build_move(c, m)
				end
			end
			if(moves.length == 0)
				cases.each do |c|
					moves_cases = Draughts_moves_helper.get_possibles_moves(c,@table)
					moves_cases.each do |m|
						moves << Draughts_tools.build_move(c, m)
					end
				end	
			end	
			choised_move = Draughts_ai.find_best_move(self, ia_color)
			choised_move = Draughts_moves_helper.define_if_move_is_capture(choised_move,table)
			if(choised_move != nil)
				Draughts_moves_helper.add_move(choised_move, table)
				while(choised_move[1] == 'x' && Draughts_capture_helper.get_capture_cases(choised_move[2].to_i, ia_color, table).length > 0)
					moves = []
					moves_cases = Draughts_capture_helper.get_capture_cases(choised_move[2].to_i, ia_color, table)
					
					moves_cases.each do |m|
						moves << Draughts_tools.build_move(choised_move[2].to_i, m)
					end
					
					choised_move = choise_better_move(moves)
					choised_move = Draughts_moves_helper.define_if_move_is_capture(choised_move,table)										
					Draughts_moves_helper.add_move(choised_move, table)
				end
				Draughts_moves_helper.check_promote_piece(choised_move, ia_color, @table)
			else
                @game_state = Draughts_tools.define_game_state(@table,@player_color)
		    end
		end
		
		def choise_better_move(moves)
			# intelligence should be define here
        
			return moves.shuffle.first
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
			
#			@table = [	'b','b','b','b','b',
#						'b','b','b','b','b',
#						'_','b','b','_','_',
#						'b','w','_','b','b',
#						'_','_','b','w','_',
#						'b','_','w','b','_',
#						'w','_','_','_','w',
#						'_','_','_','_','_',
#						'w','w','w','w','w',
#						'w','w','w','w','w']
			
#			@table = [	'_','_','_','_','_',
#						'_','_','_','_','_',
#						'_','b','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','w','_',
#						'_','_','_','_','_',
#						'_','b','b','_','_',
#						'_','_','b','_','_',
#						'_','_','_','_','_',
#						'W','_','_','_','_']

#			@table = [	'_','_','_','_','_',
#						'_','_','_','_','_',
#						'b','_','w','w','_',
#						'_','_','_','_','_',
#						'_','_','w','_','_',
#						'_','w','b','_','_',
#						'_','b','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','_','_']
						
#			@table = [	'_','_','_','_','_',
#						'_','_','w','_','_',
#						'b','_','_','w','_',
#						'_','_','_','_','_',
#						'_','_','_','w','_',
#						'_','_','b','_','_',
#						'_','b','b','_','_',
#						'_','b','b','_','_',
#						'_','b','_','_','_',
#						'_','_','_','_','_']

#			@table = [	'_','_','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','_','_',
#						'_','_','_','_','b',
#						'_','_','_','_','_',
#						'_','_','_','_','w',
#						'_','_','w','w','_',
#						'_','_','_','_','_',
#						'_','_','_','_','_']
		end
	
		def get_cases(case_number, color)
			line_number = Draughts_tools.get_line_number(case_number)
			result = []
			modificator = Draughts_moves_helper.define_modificator(color)
			if(line_number%2 == 0) 
				add_case_number_to_array(result, case_number -1 + modificator,case_number + modificator, case_number)
			elsif(line_number%2 != 0) 
				add_case_number_to_array(result, case_number + modificator,case_number +1 + modificator, case_number)
			end
			return result
		end 
		
		def get_cases_for_queen(case_number, color)
			result = []
			if(@table[case_number - 1] == 'W' || @table[case_number - 1] == 'B')
				Draughts_direction_helper.get_all_traject_for_queen(case_number, @table).each do |c|
					if(c.length > 0)
						result << case_number
						break
					end
				end
			end
			return result
		end
		
		def add_case_number_to_array(my_array, case_number_first, case_number_second, selected_case)
			last_char = selected_case.to_s.last
			if(@table[case_number_first - 1] == '_' && last_char != '6')
				my_array << selected_case
			elsif(@table[case_number_second - 1] == '_' && last_char != '5')
				my_array << selected_case
			end
			return my_array
		end
		
end
