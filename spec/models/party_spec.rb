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
    
    describe "start party" do
    
        it "Should return playground" do
            @party.player_start(['a','1','o'])
            @party.playground.should be_an_instance_of(Playground)
        end    
        
        it "Should find two move on playground" do
            @party.player_start(['a','1','o'])
            index = 0
            @party.playground.table.each do |t|
                if(t[2] != '_')
                    index += 1
                end
            end
            index.should equal(2)
        end
        
        it "Should return playground" do
            @party.ia_start()
            @party.playground.should be_an_instance_of(Playground)
        end    
        
        it "Should find one move on playground" do
            @party.ia_start()
            index = 0
            @party.playground.table.each do |t|
                if(t[2] != '_')
                    index += 1
                end
            end
            index.should equal(1)
        end
        
        it "Should don't add new move" do
            @party.ia_start()
            @party.player_play(['a','1','o'])
            @party.player_play(['a','1','o'])
            index = 0
            @party.playground.table.each do |t|
                if(t[2] == 'o')
                    index += 1
                end
            end
            index.should equal(1)
        end
    end

end
