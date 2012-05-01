class Draughts_ai

    MAX_VALUE = 100000
    MIN_VALUE = -100000
    MAX_CODE = 'max'
    MIN_CODE = 'min'
    DEPTH = 3
    
    attr_accessor :player_color
    
    def self.find_best_move(playground, color)
        @player_color = self.swicht_color(color)
    
        moves_playgrounds = []
        playgrounds = []
        
        moves = get_legal_moves(playground, color) # get all possibles move for player
        
        moves.each do |m|       
            simulate_move(m, playground, color, playgrounds) # get all playgrounds by move
            moves_playgrounds << [m,playgrounds]
            playgrounds = []
        end
        
        score = nil        
        scores = []
            
        moves_playgrounds.each do |mp|
            mp[1].each do |p|          
                score = get_score_for_move(p, MIN_CODE, color, 0, color)         
                scores << [mp[0], score]   
            end
        end   
        
        max_score = scores.map{ |x| x[1] }.max
   
        if(scores.length > 0)
            return ((scores.select {|x| x[1] == max_score}).shuffle)[0][0]
        end
        return nil
    end
    
    private
    
        def self.simulate_move(move, playground, color, playgrounds)
            pg = playground.clone()
            Draughts_moves_helper.add_move(move, pg.table) 
            Draughts_moves_helper.check_promote_piece(move, color, pg.table)
            pg.game_state = Draughts_tools.define_game_state(pg.table ,@player_color)
            if(check_move_is_capture(move))
                move_terminated = true      
                Draughts_capture_helper.get_capture_cases(move[2].to_i, color, pg.table).each do |end_case|
                    move_terminated = false
                    next_move = Draughts_tools.build_move(move[2].to_i, end_case)
                    next_move = Draughts_moves_helper.define_if_move_is_capture(next_move, pg.table)
                    simulate_move(next_move, pg, color, playgrounds)
                end
                if(move_terminated ==  true)
                    playgrounds << pg
                end
            else
                playgrounds << pg
            end          
        end
        
        def self.get_legal_moves(playground, color)
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
            
            return possibles_moves
        end
        
        def self.get_score_for_move(playground, min_or_max, max_color, depth, color_turn)      
            if(depth != DEPTH && playground.game_state == 'none')
                score = 0
                playgrounds = []
                moves = get_legal_moves(playground, self.swicht_color(color_turn)) # get all possibles move for player
                moves.each do |m|                                    
                    pg = []
                    simulate_move(m, playground, self.swicht_color(color_turn), pg)
                    pg.each do |to_add|
                        playgrounds << to_add
                    end
                end
                if(playgrounds.length > 0)
                    scores = []
                    playgrounds.each do |p|
                        scores << self.get_score_for_move(p, self.swicht_min_max(min_or_max), max_color, depth + 1, self.swicht_color(color_turn))
                    end
                    if(min_or_max == MAX_CODE)
                        score = scores.max
                    else
                        score = scores.min
                    end          
                end      
            else            
                score = get_table_score(playground, max_color, self.swicht_color(max_color), depth)
            end
            
            return score
        end 
        
        # return a table score
        # score is > 0 for max_color, < 0 for min_color
        def self.get_table_score(playground, max_color, min_color, depth)
            score = 0       
            if(playground.game_state == 'player')
                score = MIN_VALUE + depth
            elsif(playground.game_state == 'ai')
                score = MAX_VALUE - depth
            else
                score += playground.table.select { |p| p == max_color }.length # 1 point by piece
                score += 10 * playground.table.select { |p| p == max_color.upcase }.length # 10 points by queen
                score -= playground.table.select { |p| p == min_color }.length
                score -= 10 * playground.table.select { |p| p == min_color.upcase }.length 
            end
            
            return score        
        end
        
        def self.check_move_is_capture(m)
            return m[1] == 'x'
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
