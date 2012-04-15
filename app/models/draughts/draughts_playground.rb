class Draughts_playground 
    
    attr_accessor :draughts_table    
    
    def initialize()
        @draughts_table = []
        case_string = "b0"
        (0..49).each do |pos|
            if(pos == 20)
                case_string = "_0"
            end   
            if(pos == 30)
                case_string = "w0"
            end
            @draughts_table[pos] = case_string
        end
    end
    
    def get_possibles_moves(case_number)
        to_return = []
        if(case_number > 0)
            actual_case = @draughts_table[case_number - 1]
            if(actual_case[0] != '_')
                line_number = get_line_number(case_number)
                if(line_number%2 == 0 && actual_case[0] == 'w') 
                    add_case_number_to_array(to_return, case_number-6, case_number)
                    add_case_number_to_array(to_return, case_number-5, case_number)
                elsif(line_number%2 != 0 && actual_case[0] == 'w') 
                    add_case_number_to_array(to_return, case_number-5, case_number)
                    add_case_number_to_array(to_return, case_number-4, case_number)
                elsif(line_number%2 == 0 && actual_case[0] == 'b') 
                    add_case_number_to_array(to_return, case_number+4, case_number)
                    add_case_number_to_array(to_return, case_number+5, case_number)
                elsif(line_number%2 != 0 && actual_case[0] == 'b') 
                    add_case_number_to_array(to_return, case_number+5, case_number)
                    add_case_number_to_array(to_return, case_number+6, case_number)
                end
            end
        end
        return to_return;
    end 
    
    def add_move(move)
        start_case = move[0].to_i
        end_case = move[2].to_i
        if(@draughts_table[start_case - 1][0] != '_' && @draughts_table[end_case - 1][0] == '_')
            player_char = @draughts_table[start_case - 1]
            @draughts_table[start_case - 1] = '_0'
            @draughts_table[end_case - 1] = player_char
        end
    end
    
    private
    
        def get_line_number(case_number)
            return (case_number/5.0).ceil
        end
        
        def add_case_number_to_array(my_array, case_number, selected_case)
            if(@draughts_table[case_number - 1][0] == '_')  
                if(selected_case.to_s.last == '6' || selected_case.to_s.last == '5')
                    if((case_number - selected_case).abs == 5)
                        my_array << case_number
                    end
                else                             
                    my_array << case_number
                end
            end
            return my_array
        end
    
end
