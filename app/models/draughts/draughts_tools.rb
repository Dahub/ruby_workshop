#class Draughts_tools

#    def check_catch(to_return, line_number, case_number,actual_case, draughts_table)
#        piece_color = actual_case[0]
#        moves = []
#        if(line_number%2 == 0 && actual_case[0] != '_') 
#            if( case_number > 9 &&
#                draughts_table[case_number - 1 - 9][0] == '_' && 
#                draughts_table[case_number - 1 - 5][0] != piece_color &&
#                draughts_table[case_number - 1 - 5][0] != '_' &&
#                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
#                moves<< case_number - 9
#            end
#            if( case_number > 10 &&
#                draughts_table[case_number - 1 - 11][0] == '_' && 
#                draughts_table[case_number - 1 - 6][0] != piece_color &&
#                draughts_table[case_number - 1 - 6][0] != '_' && 
#                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
#                moves << case_number - 11
#            end
#            if( case_number < 39 &&
#                draughts_table[case_number - 1 + 11][0] == '_' && 
#                draughts_table[case_number - 1 + 5][0] != piece_color &&
#                draughts_table[case_number - 1 + 5][0] != '_' &&
#                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
#                moves << case_number + 11
#            end
#            if( case_number < 42 &&
#                draughts_table[case_number - 1 + 9][0] == '_' && 
#                draughts_table[case_number - 1 + 4][0] != piece_color &&
#                draughts_table[case_number - 1 + 4][0] != '_' &&
#                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
#                moves << case_number + 9
#            end
#        elsif(line_number%2 != 0 && actual_case[0] != '_')
#            if( case_number > 9 &&
#                draughts_table[case_number - 1 - 9][0] == '_' && 
#                draughts_table[case_number - 1 - 4][0] != piece_color &&
#                draughts_table[case_number - 1 - 4][0] != '_' &&
#                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
#                moves<< case_number - 9
#            end
#            if( case_number > 10 &&
#                draughts_table[case_number - 1 - 11][0] == '_' && 
#                draughts_table[case_number - 1 - 5][0] != piece_color &&
#                draughts_table[case_number - 1 - 5][0] != '_' && 
#                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
#                moves << case_number - 11
#            end
#            if( case_number < 39 &&
#                draughts_table[case_number - 1 + 11][0] == '_' && 
#                draughts_table[case_number - 1 + 6][0] != piece_color &&
#                draughts_table[case_number - 1 + 6][0] != '_' &&
#                case_number.to_s.last != '0' && case_number.to_s.last != '5' )
#                moves << case_number + 11
#            end
#            if( case_number < 42 &&
#                draughts_table[case_number - 1 + 9][0] == '_' && 
#                draughts_table[case_number - 1 + 5][0] != piece_color &&
#                draughts_table[case_number - 1 + 5][0] != '_' &&
#                case_number.to_s.last != '1' && case_number.to_s.last != '6' )
#                moves << case_number + 9
#            end
#        end
#        
#        moves.each do |m|
#            to_return << [ case_number ,'x', m ]
#        end  
#        
#        return to_return
#    end    
#    

#    
#    def add_case_number_to_array(my_array, case_number, selected_case, draughts_table)
#        if(draughts_table[case_number - 1][0] == '_')  
#            if(selected_case.to_s.last == '6' || selected_case.to_s.last == '5')
#                if((case_number - selected_case).abs == 5)
#                    my_array << [selected_case ,'-',  case_number]
#                end
#            else                             
#                my_array << [selected_case,'-', case_number]
#            end
#        end
#        return my_array
#    end
#    
#        def check_catch_for_one_case_number(case_number, move)
#        actual_case = @draughts_table[case_number - 1]
#        line_number = @draughts_tools.get_line_number(case_number)
#        @draughts_tools.check_catch(move, line_number,case_number,actual_case, @draughts_table)    
#    end
#    
#    
#     def get_cases_for_white(result, line_number,case_number,actual_case)            
#            if(line_number%2 == 0 && actual_case[0] == 'w') 
#                @draughts_tools.add_case_number_to_array(result, case_number-6, case_number, @draughts_table)
#                @draughts_tools.add_case_number_to_array(result, case_number-5, case_number, @draughts_table)
#            elsif(line_number%2 != 0 && actual_case[0] == 'w') 
#                @draughts_tools.add_case_number_to_array(result, case_number-5, case_number, @draughts_table)
#                @draughts_tools.add_case_number_to_array(result, case_number-4, case_number, @draughts_table)
#            end     
#        end
#        
#        def get_cases_for_black(result, line_number,case_number,actual_case)            
#            if(line_number%2 == 0 && actual_case[0] == 'b') 
#                @draughts_tools.add_case_number_to_array(result, case_number+4, case_number, @draughts_table)
#                @draughts_tools.add_case_number_to_array(result, case_number+5, case_number, @draughts_table)
#            elsif(line_number%2 != 0 && actual_case[0] == 'b') 
#                @draughts_tools.add_case_number_to_array(result, case_number+5, case_number, @draughts_table)
#                @draughts_tools.add_case_number_to_array(result, case_number+6, case_number, @draughts_table)
#            end         
#        end    
#        
#        def find_all_possibles_moves()
#            to_return = check_catch_pieces('b') 
#            if(to_return.length == 0)
#                to_return = find_all_possibles_moves_without_capture()
#            end
#            return to_return
#        end
#        
#        def find_all_possibles_moves_without_capture()
#            to_return = []
#            index = 0
#            @draughts_table.each do |c|
#                if(c[0] == 'b')
#                    my_moves = []
#                    case_number = index + 1
#                    actual_case = @draughts_table[case_number - 1]
#                    line_number = @draughts_tools.get_line_number(case_number)
#                    get_cases_for_black(my_moves, line_number,case_number,actual_case)
#                    my_moves.each do |m|
#                        to_return << m
#                    end
#                end
#                index += 1
#            end     
#            return to_return
#        end
#        
#        def choise_better_move(moves)
#            # intelligence should be define here
#        
#            return moves.shuffle.first
#        end
#        
#            def check_catch_pieces(color)       
#        moves = []           
#        index = 0
#        @draughts_table.each do |c|
#            if(c[0] == color)
#                case_number = index + 1
#                check_catch_for_one_case_number(case_number, moves)               
#            end
#            index += 1
#        end             
#        return moves
#    end
#    
#    def check_catch_for_one_case_number(case_number, move)
#        actual_case = @draughts_table[case_number - 1]
#        line_number = @draughts_tools.get_line_number(case_number)
#        @draughts_tools.check_catch(move, line_number,case_number,actual_case, @draughts_table)    
#    end
#    
#     def flag_move_to_capture(move)
#        puts '_______________________________________'
#        puts move.inspect
#        end_case = move[2].to_i
#        start_case = move[0].to_i
#        if(move[1] == 'x')
#            puts '############################ tralalal ###########################'
#            puts '---' + @draughts_table[end_case - 1][1].to_s
#            puts @draughts_table.inspect
#            @draughts_table[end_case - 1] = @draughts_table[end_case - 1].first + '1'
#        else
#            @draughts_table[end_case - 1] = @draughts_table[end_case - 1].first + '0'
#            @draughts_table[start_case - 1] = @draughts_table[end_case - 1].first + '0'
#        end
#        puts @draughts_table.inspect
#    end
#    
#        def find_new_move() 
#        moves = find_all_possibles_moves()
#        return choise_better_move(moves)
#    end  
#    
#        def get_possibles_moves(case_number)
#        to_return = []                
#        if(case_number > 0)
#            actual_case = @table[case_number - 1]            
#            color = actual_case[0]
#            to_return = check_catch_pieces(color)            
#            if(actual_case[0] != '_' && to_return.length == 0)
#                line_number = get_line_number(case_number)
#                get_cases_for_white(to_return,line_number,case_number,actual_case)
#                get_cases_for_black(to_return,line_number,case_number,actual_case)
#            end
#        end
#        return to_return;
#    end  
#    
#    def add_move(move)
#        start_case = move[0].to_i
#        end_case = move[2].to_i
#        if(@draughts_table[start_case - 1][0] != '_' && @draughts_table[end_case - 1][0] == '_')
#            player_char = @draughts_table[start_case - 1]
#            @draughts_table[start_case - 1] = '_0'
#            @draughts_table[end_case - 1] = player_char
#            delete_capture_pieces(move)  
#        end
##    end  
#end
