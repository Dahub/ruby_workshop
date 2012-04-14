class DraughtsController < ApplicationController
    def index
        session[:party] = Draughts_game.new()
        @table = session[:party].get_playground()
    end
end
