class Party
    attr_accessor :playground, :ia
    
    def initialize(ia)
        @ia = ia
    end
    
    def ia_start()
        next_move = find_next_move()
        @playground = Playground.new(@ia,next_move)
        return @playground
    end
    
    def player_play(move)
        
        playgound.add_move(move)
        return update_playground_by_ia()
    end   
    
    private
    
        def update_playground_by_ia()
            next_move = find_next_move()
            @playground.add_move(next_move)
            return @playground
        end
    
        def find_next_move()
            @playgound.get_all_empty_position() do |m|
                
            end
        end
end
