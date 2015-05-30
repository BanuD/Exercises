
# Assume you have: render_board(board), get_user_input() -> [x,y]

class Player
    attr_reader :sign
    attr_accessor :status, :input

    def initialize(sign)
        @sign = sign
        @status = nil #winner/looser
    end

    def get_user_input
        @input = gets.chomp
    end

end

class Board
    attr_accessor :board

    def initialize
        @board = Array.new(3, Array.new(3, "-"))
    end

    def render_board
        puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}\n #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}\n #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}\n"
    end

    def full?
        current_board = @board.flatten
        (current_board.include? "-") ? false : true
    end
end

class Game
    attr_reader :player1, :player2
    attr_accessor :board, :status
    def initialize
        @board = Board.new
        @status = "on"
        @player1 = Player.new("O")
        @player2 = Player.new("X")
    end

    def check_rows(player)
        sign = player.sign
        board_rows = @board.dup
        i = 0
        while i < @board.length
            if board_rows[i] == [sign, sign, sign]
                @player.status = "winner"
                @status = "end"
            end
            i += 1
        end
    end

    def check_columns(player)
        sign = player.sign
        board_columns = @board.dup.transpose
        i = 0
        while i < @board.length
            if board_colums[i] == [sign, sign, sign]
                @player.status = "winner"
                @status = "end"
            end
            i += 1
        end
    end

    def check_diagonals(player)
        sign = player.sign
        board_diagonals = @board.dup
        if (board_diagonals[0][0] == sign && board_diagonals[1][1] == sign && board_diagonals[2][2] == sign) || (board_diagonals[0][2] == sign && board_diagonals[1][1] == sign && board_diagonals[2][0] == sign)
            @player.status = "winner"
            @status = "end"
        end
    end


    def insert_sign(player)
        puts "Please put in the coordinates!"
        input = player.get_user_input
        x = input[1].to_i
        puts "x: #{x}"
        y = input[3]
        puts "y: #{y}"
        puts "board[x] #{@board[x]}"
        raise 'You may only choose an empty slot' unless @board[x][y] == "-"
        raise 'You have to be within board limits' if (x > 2 || y > 2)
        @board[x][y] = player.sign
    end

    def play(player)
        insert_sign(player)
        check_rows(player.sign)
        check_columns(player.sign)
        check_diagonals(player.sign)
        return "#{player} is the winner!!" if player.status == "winner"
    end
end


# play_game() should play a full two human player game
def play_tic_tac_toe
    game = Game.new
    puts "Here is the board"
    game.board.render_board
    player1 = game.player1
    player2 = game.player2

    while game.status == "on"
        game.play(player1)
        game.play(player2)

        if game.board.full?
            game.status == "end"
            puts "It's a tie!! try again"
        end
        board.render_board
    end
end

play_tic_tac_toe









