class DraughtsController < ApplicationController
    def index
        session[:party] = Draughts_game.new()
        @table = session[:party].get_playground()
    end
    
    def get_possibles_move()
        sleep 0.2
        return render :json => session[:party].get_possibles_moves(params['case_number'].to_i)  
    end
    
    def player_move()
        sleep 0.2
        my_move = params['move'].split(',')
        return render :json => session[:party].player_move(my_move)
    end
end
