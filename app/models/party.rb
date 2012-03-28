class Party < ActiveRecord::Base

    attr_accessor :ia, :player, :playground, :actual_node
    
    x_or_o_regex = /[xo]/
    
    validates :ia,  :format => { :with => x_or_o_regex }
    
    def after_initialize(ia, first_move)
        @ia = ia
        if(ia == 'x')
            @player = 'o'
        else        
            @player = 'x'
        end
        @playground = [ ['a','1','_'],
                        ['b','1','_'],
                        ['c','1','_'],
                        ['a','2','_'],
                        ['b','2','_'],
                        ['c','2','_'],
                        ['a','3','_'],
                        ['b','3','_'],
                        ['c','3','_'] ]
                        
        set_First_Node(first_move)
    end  
    
    # return true if position 'move' is empty
    def check_Position_Empty?(move)
        testing_move = move.clone
        testing_move[2] = '_'
        !(@playground.index testing_move).nil?
    end
    
    def add_player_move(move)
        if(check_Position_Empty?(move))
            add_move(move)
       #     add_ia_move()
        end
    end
    
    def add_ia_move()
       # move = @actual_node.find_next_move
       # if(check_Position_Empty?(move))
       #     add_move(move)
       # end
    end
    
    private
    
        def add_move(move)
            update_Playground(move)
            type = define_type(move)
            node = Node.new(type, move, @playground, @actual_node.move_number + 1)
            node.final = check_final(move)
            node.parent_node = @actual_node
            node.child_nodes = []        
            @actual_node.child_nodes << node        
            @actual_node = node
        end 
        
        def check_final(move)  
            return false          
        end
    
        def set_First_Node(first_move)
            update_Playground(first_move)
            type = define_type(first_move)        
            @actual_node = Node.new(type, first_move, @playground, 1)
            @actual_node.final = false
            @actual_node.parent_node = false
            @actual_node.child_nodes = []
        end
        
        def update_Playground(move)
            @playground.each do |m|
               if(m[0] == move[0] && m[1] == move[1])
                   @playground[@playground.index m] = move
               end
            end
        end
        
        def define_type(move)            
            if(move[2] == ia)
                return 'ia'
            end
            return 'player'
        end

end
