require 'spec_helper'

describe Party do
  
  before(:each) do
        @attr = { 
            :ia => 'x',
            :player => 'o',
            :actual_node => nil,
            :playground => [    ['a','1','_'],
                                ['b','1','_'],
                                ['c','1','_'],
                                ['a','2','_'],
                                ['b','2','_'],
                                ['c','2','_'],
                                ['a','3','_'],
                                ['b','3','_'],
                                ['c','3','_'] ]
            }
    end
    
    it "Should create a valid party object" do
        Party.create!(@attr)
    end
    
    it "Should user x or o for ia" do
        bad = Party.new(@attr.merge(:ia => '0'))
        bad.should_not be_valid
    end  
    
    it "Should return false because position is not empty" do
        party = Party.new(@attr)
        party.after_initialize('x',['a','1','x'])
        result = party.check_Position_Empty?(['a','1','x'])
        result.should be_false
    end
    
    it "Should return true because position is empty" do
        party = Party.new(@attr)
        party.after_initialize('x',['a','1','x'])
        result = party.check_Position_Empty?(['b','1','x'])
        result.should be_true
    end
    
    it "Should have 2 moves after initialisation + add_player_move" do
        party = Party.new(@attr)
        party.after_initialize('x',['a','1','x'])
        party.add_player_move(['a','2','o'])
        party.actual_node.move_number.should eq(2)
    end
    
end
