class Node
    
    attr_accessor :type, :final, :move, :parent_node, :child_nodes, :playground, :move_number
    
    def initialize(type, move, playground, move_number)
        @type = type
        @move = move
        @playground = playground
        @move_number = move_number
        @child_nodes = []
    end       
        
end
