require 'pry'

class TicTacToe

    attr_accessor :board, :winning_player, :winning_combo

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
        @winning_player = ""
        @winning_combo = []
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} \n-----------\n #{self.board[3]} | #{self.board[4]} | #{self.board[5]} \n-----------\n #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token = "X")
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] != " "
    end

    def valid_move?(index)
        # if index != /[0-8]/ || self.position_taken?(index)
        if index < 0 || index > 8 || self.position_taken?(index)
            return false
        end
        return true
    end

    def turn_count
        count = 0
        self.board.each do |n|
            # binding.pry
            if n != " "
                count += 1
            end
        end
        count
    end

    def current_player
        current_player = "X"
        current_count = turn_count
        if current_count.odd?
            current_player = "O"
        end
        return current_player
    end

    def turn
        user_input = gets.chomp
        selected_index = input_to_index(user_input)
        token = current_player
        if valid_move?(selected_index)
            move(selected_index, token)
            display_board
        else
            puts "Invalid move. Please try again:"
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
            if self.board[combo[0]] == "X" && self.board[combo[1]] == "X" && self.board[combo[2]] == "X"
                self.winning_player = "X"
                winning_combo = combo
                return combo
            elsif self.board[combo[0]] == "O" && self.board[combo[1]] == "O" && self.board[combo[2]] == "O"
                self.winning_player = "O"
                winning_combo = combo
                return combo
            end
        end
        return false
    end

    def full? 
        self.board.each do |n|
            if n == " "
                return false
            end
        end
        return true
    end

    def draw?
        if full? && won? == false
            return true
        else
            return false
        end
    end

    def over?
        if won? || full?
            return true
        else
            return false
        end
    end

    def winner
        if won?
            return self.winning_player
        end
    end

    def play
        while !over? && !draw?
            turn
        end
        if won?
            puts "Congratulations #{winning_player}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end

