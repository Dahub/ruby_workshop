class Draughts_transfert_data
    attr_accessor :draughts_playground_data , :catchs_pieces

    def initialize(playground, catchs_pieces)
        @draughts_playground_data = playground
        @catchs_pieces = catchs_pieces
    end
end
