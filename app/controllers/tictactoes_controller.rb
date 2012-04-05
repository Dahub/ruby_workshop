class TictactoesController < ApplicationController
  def index
  end

  def starts
    session[:player] = params['player']
    session[:party] = Party.new(Tools.swich_ia_player(session[:player]))
    if(params['accept'] == '1')
        session[:party].ia_start()
    else
        session[:party].party_start()
    end    
    @playground = session[:party].get_playground()
    @ia = session[:player]
  end
  
  def player_start
     
  end  
  
  def ask_move  
    move = params['move']
    render :text => session[:party].player_play(move.split(//));
  end
  
end
