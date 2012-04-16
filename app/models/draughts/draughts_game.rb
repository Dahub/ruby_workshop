class Draughts_game

    attr_accessor :draughts_playground

    def initialize()
        @draughts_playground = Draughts_playground.new()
    end

    def get_playground()
        to_return = "";
        @draughts_playground.draughts_table.each do |p|
            to_return += p[0] + p[1] + "#"
        end
        return to_return[0..-2]
    end
    
    def get_possibles_moves(case_number)        
        return @draughts_playground.get_possibles_moves(case_number)
    end
    
    def player_move(move)
        if(move.length != 3)
            raise "move must be a 3 char table"
        end
        @draughts_playground.add_move(move)
        ai_move = @draughts_playground.find_new_move()
        @draughts_playground.add_move(ai_move)
    end
    
    def get_party_state()
    end     

end
