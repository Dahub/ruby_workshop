class Draughts_game

    attr_accessor :draughts_playground

    def initialize()
        @draughts_playground = Draughts_playground.new()
    end

    def get_playground()
        return @draughts_playground.draughts_table
    end
    
    def get_possibles_moves(move)
    end
    
    def player_move(move)
    end
    
    def get_party_state()
    end

end
