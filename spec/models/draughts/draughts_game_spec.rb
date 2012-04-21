require 'spec_helper'

describe Draughts_game do

    before(:each) do
        @my_game = Draughts_game.new('w')      
    end
    
    it "should return valid playground" do
        @my_game.playground.table.length.should eq(50)
    end
    
    it "should get 20 white" do
        @my_game.playground.table.select { |c| c == 'w' }.length.should eq(20)
    end
    
    it "should get 20 blacks" do
        @my_game.playground.table.select { |c| c == 'b' }.length.should eq(20)
    end
    
    it "should have 10 empty cases" do
        @my_game.playground.table.select { |c| c == '_' }.length.should eq(10)
    end

#    it "should return a list of moves" do
#        @my_game.get_possibles_moves(32).length.should eq(2)
#    end    
#    
#    it "should return only one possible move" do
#        @my_game.get_possibles_moves(16).length.should eq(1)
#    end
#    
#    it "should return only one possible move" do
#        @my_game.get_possibles_moves(35).length.should eq(1)
#    end
#    
#    it "should not return possible move" do
#        @my_game.get_possibles_moves(46).length.should eq(0)
#    end
#    
#    it "should not return possible move because start case is empty" do
#        @my_game.get_possibles_moves(28).length.should eq(0)
#    end
#    
#    it "should return a valid playground" do
#        @my_game.player_move(['31','-','27'])
#        @my_game.get_playground().split('#')[26].should eq("w0")
#    end
#    
#    it "should raise an error" do
#        lambda{@my_game.player_move(['31','27'])}.should raise_error
#    end
#    
#    it "should return none" do
#        @my_game.get_party_state().should eq("none")
#    end
#    
#    it "should capture piece" do
#        @my_game.draughts_playground.draughts_table = [ 'b0','b0','_0','_0','_0','_0','_0','_0','_0','_0',
#                                                        '_0','_0','_0','_0','_0','_0','_0','_0','_0','_0',
#                                                        '_0','b0','b0','b0','b0','b0','_0','_0','w0','_0',
#                                                        '_0','_0','_0','_0','_0','_0','_0','_0','_0','_0',
#                                                        '_0','_0','_0','_0','_0','_0','_0','_0','w0','w0']
#        @my_game.player_move(['29','x','20'])             
#        @my_game.get_playground().split('#')[23].should eq("_0")
#    end    
#    
#    it "should capture two pieces" do
#        @my_game.draughts_playground.draughts_table = [ 'b0','b0','_0','_0','_0','_0','_0','_0','_0','_0',
#                                                        '_0','_0','b0','b0','b0','_0','_0','_0','_0','_0',
#                                                        '_0','b0','b0','b0','b0','b0','_0','_0','w0','_0',
#                                                        '_0','_0','_0','_0','_0','_0','_0','_0','_0','_0',
#                                                        '_0','_0','_0','_0','_0','_0','_0','_0','w0','w0']
#        @my_game.player_move(['29','x','20'])             
#        @my_game.get_playground().split('#')[13].should eq("_0")
#    end
end
