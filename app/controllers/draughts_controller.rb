class DraughtsController < ApplicationController
    def index
#        session[:party] = Draughts_game.new()
#        @table = session[:party].get_playground()
    end
    
    def get_playground
        session[:party] = Draughts_game.new('w')
        return render :json => session[:party].playground()
    end
    
    def get_possibles_move()
        sleep 0.2
        return render :json => session[:party].define_possibles_moves_cases(params['case_number'].to_i)  
    end
    
    def player_move()
        sleep 0.2
        my_move = params['move'].split(',')
        return render :json => session[:party].player_move(my_move)
    end
end
