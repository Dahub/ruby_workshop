class Draughts_playground 
    
    attr_accessor :draughts_table    
    
    def initialize()
        @draughts_table = []
        case_string = "w0"
        (0..49).each do |pos|
            if(pos == 20)
                case_string = "_0"
            end   
            if(pos == 30)
                case_string = "b0"
            end
            @draughts_table[pos] = case_string
        end
    end
    
end
