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
    end
    
    def get_party_state()
    end   

end
