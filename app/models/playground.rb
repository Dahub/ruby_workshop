class Playground

    attr_accessor :table, :ia, :player

    def initialize(ia)      
        
        check_ia(ia)
    
        @ia = ia
        if(ia == 'x')
            @player = 'o'
        else        
            @player = 'x'
        end
        @table = [  ['a','1','_'],
                    ['b','1','_'],
                    ['c','1','_'],
                    ['a','2','_'],
                    ['b','2','_'],
                    ['c','2','_'],
                    ['a','3','_'],
                    ['b','3','_'],
                    ['c','3','_'] ]                        
    end  
    
    # return could be :
    # => draw if party was over and nobody won
    # => player if party was won by player 
    # => ia if party was won by ia
    # => none if party isn't over
    def get_state()
        winner = check_vertical_line()
        if(winner != nil)
            return get_layer_or_ia(winner)
        end 
        winner = check_horizontal_line()
        if(winner != nil)
            return get_layer_or_ia(winner)
        end 
        winner = check_diagonal_line()
        if(winner != nil)
            return get_layer_or_ia(winner)
        end        
        if(get_empty_space.length == 0)
            return "draw"
        end
        return "none"          
    end       
    
    # add a move to the table
    # move muste be an array of char
    # like ['b','1','x']
    def add_move(move)
        check_move(move)
        if(check_position_empty?(move))
            return update_table(move)
        end
        return false
    end

    def remove_move(move)
        check_move(move)
        if(check_position_exists?(move))
            new_move = move.clone
            new_move[2] = '_'
            return update_table(new_move)
        end
        return false
    end
    
    def get_empty_space()
        empties = []
        table.each do |t|
            if(t[2] == '_')
                empties << t
            end
        end
        return empties
    end   
    
    private
    
        def get_layer_or_ia(pos)
            if (pos == @player)
                return "player"
            else (pos == @ia)        
                return "ia"
            end
            return nil
        end
        
        def check_vertical_line()     
            to_return = nil   
            for index in (0..2) do   
                compteur = 0
                pos = table[index * 3][2]
                for elem in (0..2) do        
                    new_pos = table[index * 3 + elem][2]               
                    if(new_pos == pos && pos != '_')
                        compteur += 1  
                        if(compteur == 3)
                            return pos
                        end
                    else
                        pos = new_pos                         
                    end            
                end                        
            end
            return nil
        end
        
        def check_horizontal_line()
            for index in (0..2) do   
                compteur = 0
                pos = table[index][2]
                for elem in (0..2) do        
                    new_pos = table[index + elem * 3][2]               
                    if(new_pos == pos && pos != '_')
                        compteur += 1  
                        if(compteur == 3)
                            return pos
                        end
                    else
                        pos = new_pos                         
                    end            
                end                        
            end
            return nil
        end
        
        def check_diagonal_line()
            comparer = table[0][2]
            if(comparer != '_' && comparer == table[4][2] && comparer == table[8][2])
                return comparer
            end
            comparer = table[2][2] 
            if(comparer != '_' && comparer == table[4][2] && comparer == table[6][2])
                return comparer
            end
            return nil
        end  
        
        def check_position_exists?(move)
            return !(@table.index move).nil?
        end

        def check_position_empty?(move)
            testing_move = move.clone
            testing_move[2] = '_'
            return !(@table.index testing_move).nil?
        end
    
        def update_table(move)
            @table.each do |m|
                if(m[0] == move[0] && m[1] == move[1])
                   @table[@table.index m] = move
                   return true
                end                
            end
            return false
        end
        
        def check_ia(ia)
            if(ia != 'x' && ia != 'o')
                raise "ia must be x or o"
            end
        end
        
        def check_move(move)
            if(move.length != 3)
                raise "move must be a 3 char table"
            end
            if(move[0] != 'a' && move[0] != 'b' && move[0] != 'c')
                raise "move first char must be a or b or c"
            end
             if(move[1] != '1' && move[1] != '2' && move[1] != '3')
                raise "move second char must be 1 or 2 or 3"
            end
            check_ia(move[2])
        end
end
