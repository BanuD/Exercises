
# Assume you have: render_board(board), get_user_input() -> [x,y]

class Player
    attr_reader :sign
    attr_accessor :status, :input

    def initialize(sign)
        @sign = sign
        @status = nil #winner/looser
    end

    def get_user_input
        user_input = gets.chomp # Format is going to be "0,0"
        x = user_input[0].to_i
        y = user_input[2].to_i
        @input = [x, y]
    end
end

class Board
    attr_accessor :layout

    def initialize
        @layout = Array.new(3) { Array.new(3, "-") }
    end

    def render_board
        puts " #{@layout[0][0]} | #{@layout[0][1]} | #{@layout[0][2]}\n #{@layout[1][0]} | #{@layout[1][1]} | #{@layout[1][2]}\n #{@layout[2][0]} | #{@layout[2][1]} | #{@layout[2][2]}\n"
    end

    def full?
        current_layout = @layout.flatten
        (current_layout.include? "-") ? false : true
    end
end

class Game
    attr_reader :player1, :player2
    attr_accessor :board, :status
    def initialize
        @board = Board.new
        @layout = @board.layout
        @status = "on"
        @player1 = Player.new("O")
        @player2 = Player.new("X")
    end

    def check_rows(player)
        sign = player.sign
        board_rows = @layout.dup
        i = 0
        while i < @layout.length
            if board_rows[i] == [sign, sign, sign]
                player.status = "winner"
                @status = "end"
            end
            i += 1
        end
    end

    def check_columns(player)
        sign = player.sign
        board_columns = @layout.dup.transpose
        i = 0
        while i < board_columns.length
            if board_columns[i] == [sign, sign, sign]
                player.status = "winner"
                @status = "end"
            end
            i += 1
        end
    end

    def check_diagonals(player)
        sign = player.sign
        diagonal1 = [@layout[0][0], @layout[1][1], @layout[2][2]]
        diagonal2 = [@layout[0][2], @layout[1][1], @layout[2][0]]

        if (diagonal1 == [sign, sign, sign]) || (diagonal2 == [sign, sign, sign])
            player.status = "winner"
            @status = "end"
        end
    end


    def insert_sign(player)
        puts "Please put in your coordinates!"
        input = player.get_user_input
        x = input[0]
        y = input[1]
        raise 'You have to be within board limits' if (x > 2 || y > 2)
        raise 'You may only choose an empty slot' unless @layout[x][y] == "-"
        @layout[x][y] = player.sign
    end

    def play(player, game)
        puts "These are the coordinates:"
        puts "0,0 | 0,1 | 0,2\n1,0 | 1,1 | 1,2\n2,0 | 2,1 | 2,2"
        puts "Here is the board"
        game.board.render_board
        insert_sign(player)
        check_rows(player)
        check_columns(player)
        check_diagonals(player)
        puts "This is the current board"
        game.board.render_board
    end
end


# play_game() should play a full two human player game
def play_tic_tac_toe
    game = Game.new
    player1 = game.player1
    player2 = game.player2

    while game.status == "on"
        puts "\n\n"
        puts "PLAYER 1 playing"
        game.play(player1, game)
        return puts "You are the winner!!" if player1.status == "winner"

        if game.board.full?
            game.status == "end"
            return puts "It's a tie -.-\nTry again!"
        end

        puts "\n\n"
        puts "PLAYER 2 playing"
        game.play(player2, game)
        return puts "You are the winner!!" if player2.status == "winner"

    end
    game.board.render_board
end

play_tic_tac_toe





