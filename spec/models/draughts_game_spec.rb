require 'spec_helper'

describe Draughts_game do

    before(:each) do
        @my_game = Draughts_game.new()
        @playground = @my_game.get_playground().split('#')
    end
    
    it "should return valid playground" do
        @playground.length.should eq(50)
    end
    
    it "should get 20 white" do
        @playground.select { |c| c[0] == 'w' }.length.should eq(20)
    end
    
    it "should get 20 blacks" do
        @playground.select { |c| c[0] == 'b' }.length.should eq(20)
    end
    
    it "should have 10 empty cases" do
        @playground.select { |c| c[0] == '_' }.length.should eq(10)
    end

    it "should return a list of moves" do
        @my_game.get_possibles_moves(32).length.should eq(2)
    end    
    
    it "should return only one possible move" do
        @my_game.get_possibles_moves(16).length.should eq(1)
    end
    
    it "should return only one possible move" do
        @my_game.get_possibles_moves(35).length.should eq(1)
    end
    
    it "should not return possible move" do
        @my_game.get_possibles_moves(46).length.should eq(0)
    end
    
    it "should not return possible move because start case is empty" do
        @my_game.get_possibles_moves(28).length.should eq(0)
    end
    
    it "should return a valid playground" do
        @my_game.player_move(['31','-','27'])
        @playground[27].should eq("w0")
    end
    
    it "should return none" do
        @my_game.get_party_state().should eq("none")
    end
    
end
