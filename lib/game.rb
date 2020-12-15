class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        @board.turn_count.even? ? @player_1 : @player_2
    end

    def won?
        WIN_COMBINATIONS.collect do |combo|
            if combo.all? {|space| @board.cells[space] == "X"}
                return combo
            elsif combo.all? {|space| @board.cells[space] == "O"}
                return combo
            end
        end
        false
    end

    def draw?
        !won? && @board.full?
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
            @board.cells[won?[0]]
        end
    end

    def turn
        player = current_player
        current_move = player.move(@board)
        if !@board.valid_move?(current_move)
          turn
        else
          puts "Turn: #{@board.turn_count+1}\n"
          @board.display
          @board.update(current_move, player)
          puts "#{player.token} moved #{current_move}"
          @board.display
          puts "\n\n"
        end
      end

    def play
        until over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end

    end



end