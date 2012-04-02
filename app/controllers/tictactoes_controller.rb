class TictactoesController < ApplicationController
  def index
  end

  def starts
    session[:player] = params['player']
    session[:party] = Party.new(Tools.swich_ia_player(session[:player]))
    if(params['accept'] == '1')
        session[:party].ia_start()
    end    
    @test = session[:party].playground.table.inspect
  end
  
  def player_start
     
  end  
  
end
