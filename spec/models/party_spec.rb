require 'spec_helper'

describe Party do

    before(:each) do
        @party = Party.new('x')
    end

    describe "initialize" do
        
        it "Should be instance of Party" do
            @party.should be_an_instance_of(Party)
        end  
        
    end

end
