class Draughts_ai

    MAX_VALUE = 1000000
    MIN_VALUE = -1000000
    MAX_CODE = 'max'
    MIN_CODE = 'min'
    DEPTH = 2
    
    def self.find_best_move(playground, color)
        moves = []
        score = nil
        possibles_moves = []
        
        cases = Draughts_moves_helper.get_cases_number_by_color(color, playground.table) # get all cases for capture
        cases.each do |start_case|
            Draughts_capture_helper.get_capture_cases(start_case, color, playground.table).each do |end_case|
                move = Draughts_tools.build_move(start_case,end_case)
                move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)
                possibles_moves << move
            end
        end
        if(possibles_moves.length == 0) # there is none capture to do
            cases.each do |start_case|
                Draughts_moves_helper.get_possibles_moves(start_case, playground.table).each do |end_case|
                    move = Draughts_tools.build_move(start_case,end_case)
                    move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)
                    possibles_moves << move
                end
            end        
        end
        
        possibles_moves.each do |move|        
            new_pg = clone_playground(playground)
            Draughts_moves_helper.add_move(move, new_pg.table) 
            if(move[1] == 'x' && Draughts_capture_helper.get_capture_cases(move[2].to_i, color, playground.table).length > 0)                      
                score = get_score_for_move(new_pg, MAX_CODE, color, 0)
            else
                score = get_score_for_move(new_pg, MIN_CODE, swicht_color(color), 0) # 0 indicate depth = 0
            end
            moves << [move, score]
        end           
            
        puts '###################################### ' + moves.inspect
            
        max_score = moves.map{ |x| x[1] }.max
        
        if(moves.length > 0)
            return ((moves.select {|x| x[1] = max_score}).shuffle)[0][0]
        end
        return nil
    end    
    
    private
        
        def self.get_score_for_move(playground, min_or_max, color, depth)
            scores = []
            playgrounds = simulate_moves(playground, color) 
            score = nil
            
            if(depth != DEPTH && playground.game_state == 'none' && playgrounds.length > 0)        
                playgrounds.each do |pg|                                   
                    score = get_score_for_move(pg, swicht_min_max(min_or_max), swicht_color(color), depth + 1)                               
                    scores << score
                end
                # choise min or max score
                if(min_or_max == MAX_CODE)
                    score = scores.max            
                else
                    score = scores.min  
                end

            else # end of tree, calc score
                score = get_table_score(playground, color, swicht_color(color))                
            end    
            
            return score
        end
        
        def self.simulate_moves(playground, color)
            playgrounds = []            
            possibles_moves = []
            
            cases = Draughts_moves_helper.get_cases_number_by_color(color, playground.table)
            cases.each do |start_case| 
                move = ''  
                new_pg = clone_playground(playground)
                Draughts_capture_helper.get_capture_cases(start_case, color, playground.table).each do |end_case|
                    move = Draughts_tools.build_move(start_case,end_case)
                    move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)                      
                    Draughts_moves_helper.add_move(move, new_pg.table) 
                    if(move[1] == 'x' && Draughts_capture_helper.get_capture_cases(move[2].to_i, color, playground.table).length > 0)
                        simulate_moves(playground, color)                    
                    end 
                end
                if(move == '')
                    Draughts_moves_helper.get_possibles_moves(start_case, playground.table).each do |end_case|
                        move = Draughts_tools.build_move(start_case,end_case)
                        move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)  
                        Draughts_moves_helper.add_move(move, new_pg.table) 
                        if(move[1] == 'x' && Draughts_capture_helper.get_capture_cases(move[2].to_i, color, playground.table).length > 0)
                            simulate_moves(playground, color)
                        end
                    end
                end
                playgrounds << new_pg
            end
            
            return playgrounds
        end

        # return a table score
        # score is > 0 for max_color, < 0 for min_color
        def self.get_table_score(playground, max_color, min_color)
            score = 0
        
            if(playground.game_state == 'player')
                score = MIN_VALUE + depth
            elsif(playground.game_state == 'ai')
                score = MAX_VALUE - depth
            else
                score += playground.table.select { |p| p == max_color }.length # 1 point by piece
                score += playground.table.select { |p| p == max_color.upcase }.length # 10 points by queen
                score -= playground.table.select { |p| p == min_color }.length
                score -= playground.table.select { |p| p == min_color.upcase }.length 
            end
            
            return score        
        end
        
        def self.clone_playground(pg)
            my_playground = Draughts_playground.new(pg.player_color)            
            my_playground.set_new_table(pg.table.clone()) 
            return my_playground
        end
        
        def self.swicht_min_max(value)
            if(value == MAX_CODE)
                return MIN_CODE
            end
            return MAX_CODE
        end
        
        def self.swicht_color(value)
            if(value == 'w')
                return 'b'
            end
            return 'w'
        end
end
