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
#    
#    def player_move(move)
#        if(move.length != 3)
#            rahts_playground.add_move(move)
#        @draughts_playground.flag_move_to_capture(move) 
#        if(move[1] == 'x') # piece was captured
#            moves = []
#            @draughts_playground.check_catch_for_one_case_number(move[2].to_i, moves)           
#            if(moves.length == 0)
#                play_ai_move()   
#            end
#        else
#            play_ai_move()
#        end
#        #puts @draughts_playground.draughts_table.inspect
#        return Draughts_transfert_data.new(@draughts_playground.draughts_table,'') 
#    end
#    
#    def get_party_state()
#    end     
#    
#    private 
#    
#        def play_ai_move()
#            ai_move = @draughts_playground.find_new_move()
#            @draughts_playground.add_move(ai_move)
#        end

end
