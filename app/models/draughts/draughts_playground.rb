class Draughts_playground 
    
    attr_accessor :draughts_table    
    
    def initialize()
        @draughts_table = []
        @draughts_tools = Draughts_tools.new()
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
            
            color = actual_case[0]
            to_return = check_catch_pieces(color)
            
            if(actual_case[0] != '_' && to_return.length == 0)
                line_number = @draughts_tools.get_line_number(case_number)
                get_cases_for_white(to_return,line_number,case_number,actual_case)
                get_cases_for_black(to_return,line_number,case_number,actual_case)
            end
        end
        return to_return;
    end 
    
    def check_catch_pieces(color)       
        to_return = []           
        index = 0
        @draughts_table.each do |c|
            if(c[0] == color)
                case_number = index + 1
                actual_case = @draughts_table[case_number - 1]
                line_number = @draughts_tools.get_line_number(case_number)
                @draughts_tools.check_catch(to_return, line_number,case_number,actual_case, @draughts_table)                
            end
            index += 1
        end             
        return to_return
    end
    
    def add_move(move)
        start_case = move[0].to_i
        end_case = move[2].to_i
        if(@draughts_table[start_case - 1][0] != '_' && @draughts_table[end_case - 1][0] == '_')
            player_char = @draughts_table[start_case - 1]
            @draughts_table[start_case - 1] = '_0'
            @draughts_table[end_case - 1] = player_char
            delete_capture_pieces(move)   
        end
        return Draughts_transfert_data.new(@draughts_table,'')        
    end
    
    def find_new_move()
        moves = find_all_possibles_moves()
        return choise_better_move(moves)
    end
    
    private   
    
        def delete_capture_pieces(move)
            if(move[1] == 'x')
                start_case = move[0].to_i
                end_case = move[2].to_i
                capture_line_number = (@draughts_tools.get_line_number(start_case) + @draughts_tools.get_line_number(end_case)) / 2
                case_number = 0
                if(capture_line_number%2 != 0)
                    case_number = (start_case + end_case - 1)/2
                else 
                    case_number = (start_case + end_case + 1)/2
                end
                @draughts_table[case_number - 1] = '_0'
            end
        end
    
        def get_cases_for_white(result, line_number,case_number,actual_case)            
            if(line_number%2 == 0 && actual_case[0] == 'w') 
                @draughts_tools.add_case_number_to_array(result, case_number-6, case_number, @draughts_table)
                @draughts_tools.add_case_number_to_array(result, case_number-5, case_number, @draughts_table)
            elsif(line_number%2 != 0 && actual_case[0] == 'w') 
                @draughts_tools.add_case_number_to_array(result, case_number-5, case_number, @draughts_table)
                @draughts_tools.add_case_number_to_array(result, case_number-4, case_number, @draughts_table)
            end     
        end
        
        def get_cases_for_black(result, line_number,case_number,actual_case)            
            if(line_number%2 == 0 && actual_case[0] == 'b') 
                @draughts_tools.add_case_number_to_array(result, case_number+4, case_number, @draughts_table)
                @draughts_tools.add_case_number_to_array(result, case_number+5, case_number, @draughts_table)
            elsif(line_number%2 != 0 && actual_case[0] == 'b') 
                @draughts_tools.add_case_number_to_array(result, case_number+5, case_number, @draughts_table)
                @draughts_tools.add_case_number_to_array(result, case_number+6, case_number, @draughts_table)
            end         
        end    
        
        def find_all_possibles_moves()
            to_return = []
           
            index = 0
            @draughts_table.each do |c|
                if(c[0] == 'b')
                    my_moves = []
                    case_number = index + 1
                    actual_case = @draughts_table[case_number - 1]
                    line_number = @draughts_tools.get_line_number(case_number)
                    get_cases_for_black(my_moves, line_number,case_number,actual_case)
                    my_moves.each do |m|
                        to_return << m
                    end
                end
                index += 1
            end     
            
            return to_return
        end
        
        def choise_better_move(moves)
            # intelligence should be define here
        
            return moves.shuffle.first
        end
    
end
