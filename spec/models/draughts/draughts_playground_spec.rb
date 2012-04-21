require 'spec_helper'

describe Draughts_playground do

    before(:each) do
        @my_playground = Draughts_playground.new('b')      
    end
    
    it "Should find five selected cases for white" do
    	@my_playground.define_preselected_cases()
    	@my_playground.preselected_cases.length.should eq(5)
    end
    
    it "Should find five selected cases for black" do
    	@my_playground.define_preselected_cases()
    	@my_playground.preselected_cases.length.should eq(5)
    end
    
end
