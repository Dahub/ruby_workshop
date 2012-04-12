require 'spec_helper'

describe Draughts_game do

    before(:each) do
        @my_game = Draughts_game.new()
    end
    
    it "should return valid playground" do
        @my_game.get_playground().length.should eq(50)
    end
    
    it "should get 20 white" do
        @my_game.get_playground().select { |c| c[0] == 'w' }.length.should eq(20)
    end
    
    it "should get 20 blacks" do
        @my_game.get_playground().select { |c| c[0] == 'b' }.length.should eq(20)
    end
    
    it "should have 10 empty cases" do
        @my_game.get_playground().select { |c| c[0] == '_' }.length.should eq(10)
    end

    it "should return a list of moves" do
        @my_game.get_possibles_moves().length.should eq(9)
    end    
    
    it "should return a valid playground" do
        @my_game.player_move(['31','-','27'])
        @my_game.get_playground()[27].should eq("w0")
    end
    
    it "should return none" do
        @my_game.get_party_state().should eq("none")
    end
    
end
