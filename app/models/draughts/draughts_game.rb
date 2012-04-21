class Draughts_game

    attr_accessor :playground

    def initialize(player_color)
        @player_color = player_color
        @playground = Draughts_playground.new(player_color)
        @playground.define_preselected_cases()
    end
    
    def define_possibles_moves_cases(case_number)    
        @playground.define_preselected_cases()    
        @playground.define_possibles_moves_cases(case_number)
        return @playground
    end
    
    def player_move(move)
        @playground.player_move(move)
        return @playground
    end
end
