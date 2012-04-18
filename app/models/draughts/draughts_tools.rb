class Draughts_tools

    def check_catch(to_return, line_number, case_number,actual_case, draughts_table)
        piece_color = actual_case[0]
        moves = []
        if(line_number%2 == 0 && actual_case[0] != '_') 
            if( case_number > 9 &&
                draughts_table[case_number - 1 - 9][0] == '_' && 
                draughts_table[case_number - 1 - 5][0] != piece_color &&
                draughts_table[case_number - 1 - 5][0] != '_' &&
                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
                moves<< case_number - 9
            end
            if( case_number > 10 &&
                draughts_table[case_number - 1 - 11][0] == '_' && 
                draughts_table[case_number - 1 - 6][0] != piece_color &&
                draughts_table[case_number - 1 - 6][0] != '_' && 
                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
                moves << case_number - 11
            end
            if( case_number < 39 &&
                draughts_table[case_number - 1 + 11][0] == '_' && 
                draughts_table[case_number - 1 + 5][0] != piece_color &&
                draughts_table[case_number - 1 + 5][0] != '_' &&
                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
                moves << case_number + 11
            end
            if( case_number < 42 &&
                draughts_table[case_number - 1 + 9][0] == '_' && 
                draughts_table[case_number - 1 + 4][0] != piece_color &&
                draughts_table[case_number - 1 + 4][0] != '_' &&
                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
                moves << case_number + 9
            end
        elsif(line_number%2 != 0 && actual_case[0] != '_')
            if( case_number > 9 &&
                draughts_table[case_number - 1 - 9][0] == '_' && 
                draughts_table[case_number - 1 - 4][0] != piece_color &&
                draughts_table[case_number - 1 - 4][0] != '_' &&
                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
                moves<< case_number - 9
            end
            if( case_number > 10 &&
                draughts_table[case_number - 1 - 11][0] == '_' && 
                draughts_table[case_number - 1 - 5][0] != piece_color &&
                draughts_table[case_number - 1 - 5][0] != '_' && 
                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
                moves << case_number - 11
            end
            if( case_number < 39 &&
                draughts_table[case_number - 1 + 11][0] == '_' && 
                draughts_table[case_number - 1 + 6][0] != piece_color &&
                draughts_table[case_number - 1 + 6][0] != '_' &&
                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
                moves << case_number + 11
            end
            if( case_number < 42 &&
                draughts_table[case_number - 1 + 9][0] == '_' && 
                draughts_table[case_number - 1 + 5][0] != piece_color &&
                draughts_table[case_number - 1 + 5][0] != '_' &&
                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
                moves << case_number + 9
            end
        end
        
        moves.each do |m|
            to_return << [ case_number ,'x', m ]
        end  
        
        return to_return
    end    
    
    def get_line_number(case_number)
        return (case_number/5.0).ceil
    end  
    
    def add_case_number_to_array(my_array, case_number, selected_case, draughts_table)
        if(draughts_table[case_number - 1][0] == '_')  
            if(selected_case.to_s.last == '6' || selected_case.to_s.last == '5')
                if((case_number - selected_case).abs == 5)
                    my_array << [selected_case ,'-',  case_number]
                end
            else                             
                my_array << [selected_case,'-', case_number]
            end
        end
        return my_array
    end
    
end
