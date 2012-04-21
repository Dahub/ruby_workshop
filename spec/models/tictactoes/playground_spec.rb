require 'spec_helper'

describe Playground do

    before(:each) do
        @new_playground = Playground.new('x')
    end
    
    describe "initialize" do
       
        it "ia should be x or o" do
            x_or_o_regex = /[xo]/
            (@new_playground.ia =~ x_or_o_regex).should be_true
        end
        
        it "player should be x or o" do
            x_or_o_regex = /[xo]/
            (@new_playground.player =~ x_or_o_regex).should be_true
        end
        
        it "player should be different from ia" do
            (@new_playground.player == @new_playground.ia).should be_false
        end        
       
    end
    
    describe "add_move" do
         it "should raise bad move error" do
            lambda{@new_playground.add_move(['2','1','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.add_move('o')}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.add_move(['b','0','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.add_move(['d','1','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.add_move(['b','5','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.add_move(['a','2','8'])}.should raise_error
        end 
        
        it "should not raise bad move error" do
            lambda{@new_playground.add_move(['a','2','o'])}.should_not raise_error
        end
        
        it "should be false" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','1','o']).should be_false
        end        
        
        it "should be true" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','2','o']).should be_true
        end
        
        it "should be equal to o" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','2','o'])
            @new_playground.table[3][2].should eq('o')
        end
    end
    
    describe "remove_move" do
    
         it "should raise bad move error" do
            lambda{@new_playground.remove_move(['2','1','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.remove_move('o')}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.remove_move(['b','0','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.remove_move(['d','1','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.remove_move(['b','5','x'])}.should raise_error
        end 
        
        it "should raise bad move error" do
            lambda{@new_playground.remove_move(['a','2','8'])}.should raise_error
        end 
        
        it "should not raise bad move error" do
            lambda{@new_playground.remove_move(['a','1','x'])}.should_not raise_error
        end
        
        it "should_be_false" do
            @new_playground.remove_move(['b','2','o']).should be_false
        end
        
        it "should_be_true" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.remove_move(['a','1','x']).should be_true
        end
        
        it "should be equal to _" do
            @new_playground.remove_move(['a','1','x'])
            @new_playground.table[0][2].should eq('_')
        end
    end
    
    describe "get_state" do
        it "should_eq none" do
            @new_playground.get_state().should eq("none")
        end
        
        it "should eq player" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['c','3','o'])
            @new_playground.add_move(['a','3','x'])
            @new_playground.add_move(['c','2','o'])
            @new_playground.add_move(['b','3','x'])
            @new_playground.add_move(['c','1','o'])
            @new_playground.get_state().should eq("player")
        end
        
        it "should eq player" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['c','2','o'])
            @new_playground.add_move(['a','3','x'])
            @new_playground.add_move(['b','2','o'])
            @new_playground.add_move(['b','3','x'])
            @new_playground.add_move(['a','2','o'])
            @new_playground.get_state().should eq("player")
        end
        
         it "should eq player" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','3','o'])
            @new_playground.add_move(['a','2','x'])
            @new_playground.add_move(['b','2','o'])
            @new_playground.add_move(['c','3','x'])
            @new_playground.add_move(['c','1','o'])
            @new_playground.get_state().should eq("player")
        end
        
        it "should eq draw" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','3','o'])
            @new_playground.add_move(['a','2','x'])
            @new_playground.add_move(['b','2','o'])
            @new_playground.add_move(['c','3','x'])
            @new_playground.add_move(['b','1','o'])
            @new_playground.add_move(['b','3','x'])
            @new_playground.add_move(['c','2','o'])
            @new_playground.add_move(['c','1','x'])
            @new_playground.get_state().should eq("draw")
        end
        
         it "should eq ia" do
            @new_playground.add_move(['a','1','x'])
            @new_playground.add_move(['a','3','o'])
            @new_playground.add_move(['c','3','x'])
            @new_playground.add_move(['c','1','o'])
            @new_playground.add_move(['b','2','x'])
            @new_playground.get_state().should eq("ia")
        end
    end
    
end
