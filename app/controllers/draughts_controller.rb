class DraughtsController < ApplicationController
    def index
        session[:party] = Draughts_game.new()
        @table = session[:party].get_playground()
    end
    
    def get_possibles_move()
        return render :json => session[:party].get_possibles_moves(params['case_number'].to_i)  
    end
end
