class Draughts_direction_helper

	COL_LAST_DIGIT_LIST = [6,1,7,2,8,3,9,4,0,5]

    def initialize()
    end    
    
    def self.define_move_direction(move)
		direction = ''
		start_case = move[0].to_i
		end_case = move[2].to_i
		start_line_number = Draughts_tools.get_line_number(start_case)
		end_line_number = Draughts_tools.get_line_number(end_case)
		start_last_digit = move[0].last			
		end_last_digit = move[2].last
		if(start_line_number < end_line_number)
			direction << 'S'
		else
			direction << 'N'
		end
		if(COL_LAST_DIGIT_LIST.index(start_last_digit.to_i) < COL_LAST_DIGIT_LIST.index(end_last_digit.to_i))
			direction << 'E'
		else
			direction << 'O'
		end
		return direction
	end
	
	def self.get_moves_for_one_direct(direction,start_case,end_case)
		first_step = 0
		second_step = 0
		case direction  
		  when 'NO' 
			first_step = -6
			second_step = -5
		  when 'NE'
		  	first_step = -5
			second_step = -4
		  when 'SO'
			first_step = +4
			second_step = +5
		  else  
			first_step = +5
			second_step = +6
		end  
		if(Draughts_tools.get_line_number(start_case)%2 != 0) # switch values
			temp = first_step
			first_step = second_step
			second_step = temp
		end
		return get_cases_between_two_cases(start_case, end_case, first_step, second_step)
	end
	
	def self.get_all_traject_for_queen(case_number, table)
	    trajects = []
	    index = 0
	    init_directions(case_number).each do |direction|
	        trajects[index] = get_cases_through_borders(case_number,direction[0],direction[1], table, direction[2])                    
	        index += 1
	    end	    
	    
	    return trajects
	end
	
	def self.get_all_traject_for_queen_without_stop(case_number)
	    trajects = []
	    index = 0   
        init_directions(case_number).each do |direction|		                
	        trajects[index] = get_cases_through_borders(case_number,direction[0],direction[1], nil, direction[2])                    
	        index += 1
	    end	         
           
	    return trajects
	end
	
	private

        def self.init_directions(case_number)
            north_west = [-6,-5,'NO']
	        north_east = [-5,-4,'NE']
	        south_west = [4,5,'SO']
	        south_east = [5,6,'SE']
	        
	        if(Draughts_tools.get_line_number(case_number)%2 != 0)
	            switch_values_in_tab(north_west)
	            switch_values_in_tab(north_east)
	            switch_values_in_tab(south_west)
	            switch_values_in_tab(south_east)
	        end
	        return [north_west,north_east,south_west,south_east]
        end

        def self.switch_values_in_tab(tab)
            temp = tab[0]
            tab[0] = tab[1]
            tab[1] = temp
        end	
	    
	    def self.get_cases_through_borders(start_case, first_step, second_step, table, direction)
	        cases = []
			switch_step = false
			continue = true
			actual_case = start_case
			
			begin
				if(switch_step == true)
					actual_case += second_step
					switch_step = false
				else
					actual_case += first_step
					switch_step = true
				end		
				if(actual_case < 1)
				    continue = false
				elsif(start_case.to_s.last == '6' && actual_case.to_s.last == '0' && direction.last == 'O')		   
				    continue = false
				elsif(start_case.to_s.last == '5' && actual_case.to_s.last == '1' && direction.last == 'E')
				    continue = false
				elsif(table != nil && table[actual_case -1] != '_')
				    continue = false
				elsif(actual_case.to_s.last == '6' || actual_case.to_s.last == '5')
					cases << actual_case
					continue = false				
				elsif(Draughts_tools.get_line_number(actual_case) == 1 || Draughts_tools.get_line_number(actual_case) == 10)
					cases << actual_case
					continue = false
				else
					cases << actual_case			
				end
			end while continue == true
			return cases
	    end
	     
		def self.get_cases_between_two_cases(start_case, end_case, first_step, second_step)
			cases = []
			switch_step = false
			continue = true
			actual_case = start_case
			begin
				if(switch_step == true)
					actual_case += second_step
					switch_step = false
				else
					actual_case += first_step
					switch_step = true
				end
			
				if(actual_case == end_case)
					continue = false
				elsif(actual_case.to_s.last == '6' || actual_case.to_s.last == '5')
					cases << actual_case
					continue = false
				elsif(Draughts_tools.get_line_number(actual_case) == 1 || Draughts_tools.get_line_number(actual_case) == 10)
					cases << actual_case
					continue = false
				else
					cases << actual_case			
				end
			end while continue == true
			
			return cases
		end
end
