class Draughts_ai

    MAX_VALUE = 1000000
    MIN_VALUE = -1000000
    MAX_CODE = 'max'
    MIN_CODE = 'min'
    DEPTH = 2

    # build a table result of each move
#    def self.simulate_move(table, color)
#        root_node = Draughts_node.new(table, nil, MIN_CODE, nil, 0)
#        tables = []
#        cases = Draughts_moves_helper.get_cases_number_by_color(color, table)
#        cases.each do |start_case|            
#            Draughts_moves_helper.get_possibles_moves(start_case, table).each do |end_case|
#                move = Draughts_tools.build_move(start_case,end_case)
#                move = Draughts_moves_helper.define_if_move_is_capture(move, table)
#                if(move[1] != 'x')
#                   new_table = table.clone().add_move(move)
#                else                    
#                    simulate_move(new_table,color)
#                end
#                tables << new_table
#            end
#        end
#        puts moves.inspect
#    end

    # color_turn is ai_color
#    def self.build_tree(playground, color_turn)
#    end
    
    def self.find_best_move(playground, color)
        actual_depth = 0
        min_or_max = MAX_CODE
        moves = []
        cases = Draughts_moves_helper.get_cases_number_by_color(color, playground.table) # get all cases
        cases.each do |start_case|
            Draughts_moves_helper.get_possibles_moves(start_case, playground.table).each do |end_case|
                move = Draughts_tools.build_move(start_case,end_case)
                move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)
                score = get_score_for_move(playground,min_or_max,move,color)
                moves << [move,score]
            end
        end
        puts moves.inspect
    end    
    
    def self.get_score_for_move(playground, min_or_max, move, max_color, depth)
        scores = []
        my_playground = playground.clone()    
        moves = simulate_move(my_playground, move) # here, add move to playground, and return next moves possible for other player       
        score = nil
        
        if(depth != DEPTH && playground.game_state == 'none')        
            moves.each do |m|               
                score = get_score_for_move(my_playground, swicht_min_max(min_or_max), m, max_color, depth + 1)                
            end
            scores << [m,score]
            # choise min or max score
            if(min_or_max == MAX_CODE)
                score = scores.max{ |x,y| x[1] <=> y[1] }
            else
                score = scores.min{ |x,y| x[1] <=> y[1] }
            end
        else # end of tree, calc score
            score = get_table_score(my_playground, max_color, swicht_color(max_color))
        end
        
        return score
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
