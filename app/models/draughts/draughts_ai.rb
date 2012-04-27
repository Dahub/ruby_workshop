class Draughts_ai

    MAX_VALUE = 1000000
    MIN_VALUE = -1000000
    MAX_CODE = 'max'
    MIN_CODE = 'min'
    DEPTH = 3
    
    def self.find_best_move(playground, color)
        actual_depth = 0
        min_or_max = MAX_CODE
        moves = []
        cases = Draughts_moves_helper.get_cases_number_by_color(color, playground.table) # get all cases
        cases.each do |start_case|           
            Draughts_moves_helper.get_possibles_moves(start_case, playground.table).each do |end_case|
                move = Draughts_tools.build_move(start_case,end_case)
                move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)           
                score = get_score_for_move(playground, min_or_max, move, color, 0)
                moves << [move, score]
            end           
        end
        max_score = moves.map{ |x| x[1] }.max
        
        puts max_score.to_s
    end    
    
    private
        
        def self.get_score_for_move(playground, min_or_max, move, max_color, depth)
            scores = []
            my_playground = Draughts_playground.new(swicht_color(max_color))            
            my_playground.set_new_table(playground.table.clone()) 
            moves = simulate_move(my_playground, move) # here, add move to playground, and return next moves possible for other player       
            score = nil
            
            if(depth != DEPTH && my_playground.game_state == 'none' && moves.length > 0)        
                moves.each do |m|                                   
                    score = get_score_for_move(my_playground, swicht_min_max(min_or_max), m, max_color, depth + 1)                               
                    scores << [m,score]
                end
                # choise min or max score
                if(min_or_max == MAX_CODE)
                    score = scores.map{ |x| x[1] }.max            
                else
                    score = scores.map{ |x| x[1] }.min  
                end

            else # end of tree, calc score
                score = get_table_score(my_playground, max_color, swicht_color(max_color))                
            end    
            
            return score
        end
        
        def self.simulate_move(playground, move)
            moves = []
            color = playground.table[move[0].to_i - 1]            
           # puts '###############################" ' + move.inspect
            Draughts_moves_helper.add_move(move, playground.table)                
          #  moves_cases = []
          #  moves_cases = Draughts_capture_helper.get_capture_cases(move[2].to_i, color, playground.table)
   #
            Draughts_moves_helper.get_cases_number_by_color(color, playground.table).each do |start_case|
                moves_cases = Draughts_moves_helper.get_possibles_moves(start_case, playground.table)
                moves_cases.each do |end_case|
                    move = Draughts_tools.build_move(start_case, end_case)
                    move = Draughts_moves_helper.define_if_move_is_capture(move, playground.table)   
                    moves << move
                end
            end
       #     end     
       
                   
           # puts '####################### ' + moves_cases.inspect              
           
          #  puts '####################### ' + color + '////' + move.inspect + '////' + moves.inspect 

            return moves
        end
        
#        def self.build_capture_sequences(playground, move, color, sequences)  
#            add_move_sequence(playground, move)    
#            sequences << move
#            Draughts_capture_helper.get_capture_cases(move[2].to_i, color, playground.table).each do |m|
#                if(m[1] == 'x')                    
#                    build_capture_sequence(playground.clone(), m, color, sequences)
#                else
#                    sequences << m
#                    sequences = sequences.clone()
#                end
#            end
#             
#            return sequences
#        end
        
#        def self.add_move_sequence(playground, playground_moves)
#            playground_moves.each do |m|
#                Draughts_moves_helper.add_move(m, playground.table)
#            end
#            return playground
#        end

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
