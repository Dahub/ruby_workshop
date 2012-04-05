class Party
    attr_accessor :playground, :ia
    
    def initialize(ia)
        @ia = ia
    end
    
    def ia_start()
        @playground = Playground.new(@ia)
        #next_move = find_next_move()
        next_move = ['b','2',@ia]
        @playground.add_move(next_move)
        return @playground
    end
    
    def player_start(move)
        @playground = Playground.new(@ia)
        player_play(move)
        return @playground
    end
    
    def player_play(move)        
        @playground.add_move(move)
        update_playground_by_ia()
        return get_playground()
    end   
    
    def party_state()
        if(@playground != nil)
            return @playground.get_state()
        end
        return nil
    end
    
    def get_playground()
        to_return = "";
        @playground.table.each do |p|
            to_return += p[0] + p[1] + p[2] + "#"
        end
        return to_return
    end
    
    private
    
        def update_playground_by_ia()
            next_move = find_next_move()
            @playground.add_move(next_move)
            return @playground
        end
    
        def find_next_move()
            @possibles_moves = []
            @playground.get_empty_space().each do |m| 
                @draw_end = 0
                @player_end = 0
                @ia_end = 0
                @draw_time = 10
                @player_win_time = 10
                @ia_win_time = 10
                @time = 0
                m[2] = @ia  
                simulate_new_move(m) 
                @possibles_moves << [m,@draw_end,@player_end,@ia_end,@draw_time,@player_win_time,@ia_win_time]
            end
            return find_best_move()
        end    
        
        # search best move in @possibles_moves
        # @possibles_moves is an array
        # @possibles_moves[0] is move
        # @possibles_moves[1] is number of draw final
        # @possibles_moves[2] is number of player final
        # @possibles_moves[3] is number of ia final
        # @possibles_moves[5] is number of move to got draw
        # @possibles_moves[6] is number of move to got player victory
        # @possibles_moves[7] is number of move to got ia victory
        def find_best_move()
       
            to_return = nil          
  
            to_return = avoid_immediate_loss()
            
            if(to_return == nil || to_return[0] == nil)        
                to_return = search_certain_ia_victory()              
            end          
            if(to_return == nil || to_return[0] == nil)
                to_return = search_non_loosing_move()
            end
            if(to_return == nil || to_return[0] == nil)
                to_return = search_best_win_chance_move()
            end
            if(to_return == nil || to_return[0] == nil)
                to_return == search_best_draw_chance_move()
            end
            if(to_return == nil || to_return[0] == nil)
                to_return = (@possibles_moves.sample)[0]
            end    
                       
            return to_return        
        end
        
        def avoid_immediate_loss()
            moves = @possibles_moves.select { |m| m[5] != 2 }
            if(moves.length == 1)
                return moves[0][0]
            end
            return nil
        end   
        
        def search_certain_ia_victory()
            moves = @possibles_moves.select { |m| m[1] == 0 && m[2] == 0}
            if(moves.length > 0)
                return moves.sample[0]
            end
            return nil
        end   
        
        def search_non_loosing_move() 
            to_return = nil  
            moves = @possibles_moves.select { |m| m[2] == 0}     
            if(moves.length > 0)  
                test_var = moves[0][3]          
                moves.each do |m|
                    if(m[3] >= test_var)
                        test_var = m[3]
                        to_return = m[0]
                    end
                end
            end
            return to_return
        end
        
        def search_best_win_chance_move()
            to_return = nil
            test_var = @possibles_moves[0][3]
            ok_moves = []
            @possibles_moves.each do |m|  
                if(m[3] > test_var)
                    test_var = m[3]
                    ok_moves = [m[0]]
                elsif(m[3] == test_var)
                    ok_moves << m[0]
                end
            end
            if(ok_moves.length > 0)
                to_return = ok_moves.sample
            end
            return to_return
        end
        
        def search_best_draw_chance_move()
            to_return = nil
            test_var = @possibles_moves[0][2]
            ok_moves = []
            @possibles_moves.each do |m|  
                if(m[2] > test_var)
                    test_var = m[2]
                    ok_moves = [m[0]]
                elsif(m[2] == test_var)
                    ok_moves << m[0]
                end
            end
            if(ok_moves.length > 0)
                to_return = ok_moves.sample
            end
            return to_return
        end
        
        def simulate_new_move(move)  
            @playground.add_move(move)
            @time += 1
            state = @playground.get_state()
            if(state == "none")
                @playground.get_empty_space().each do |m|  
                    m[2] = swich_ia_player(move[2])  
                    simulate_new_move(m) 
                end
            elsif(state == "draw")
                @draw_end += 1
                if(@time < @draw_time)
                    @draw_time = @time
                end
            elsif(state == "player")
                @player_end += 1
                if(@time < @player_win_time)
                    @player_win_time = @time
                end
            elsif(state == "ia")
                @ia_end += 1
                if(@time < @ia_win_time)
                    @ia_win_time = @time
                end
            end
            @playground.remove_move(move)
            @time -= 1
        end  
        
        def swich_ia_player(value)
            if(value == 'x')
                return 'o'
            else(value = 'o')
                return 'x'
            end
            return nil
        end
end
