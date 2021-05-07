SEPARATOR = "-------------"
COLSEP = "|"

class Cell
    attr_accessor :number , :indexI, :indexJ
    def initialize(number, indexI, indexJ)
        @number = number
        @indexI = indexI
        @indexJ = indexJ
    end
end

module Interface
    
    def welcome()
        puts ""
        puts "Welcome to Tic Tac Toe"
        puts ""
        puts ""
        puts "Player 1 uses O, Player 2 uses X"
        puts ""
    end    
    
    def print_board(boardarray)
        boardarray.each_with_index do |sub_array, j|
            if j != 0
                 puts SEPARATOR
            end
            sub_array.each_with_index do |item, i|
                if i == 0
                    print COLSEP + " #{item.number} "
                elsif i == sub_array.length - 1
                    puts " #{item.number} " + COLSEP
                else
                    print COLSEP + " #{item.number} " + COLSEP
                end
            end
        end
        puts ""
    end

    def check_winner(boardarray, playerChoice)
        col = 0
        row = 0
        diag = 0
        rdiag = 0
        winner = false
        i = 0
        for i in 0..2
            if boardarray[playerChoice.indexI][i].number == playerChoice.number 
                col += 1
            end
            if boardarray[i][playerChoice.indexJ].number == playerChoice.number
                row += 1
            end
            if boardarray[i][i].number == playerChoice.number 
                diag += 1
            end
            if boardarray[i][(2-i)].number == playerChoice.number 
                rdiag += 1
            end
        end
        if ((row == 3) || (col == 3) || (diag == 3) || (rdiag == 3)) 
                winner = true
        end
        winner
    end

    def check_fullBoard(boardarray)
        count = 0
        boardfull = false
        boardarray.each do |sub_array|
            sub_array.each do |item|
                if ((item.number != "O") && (item.number != "X"))
                    count += 1
                end
            end 
        end
        if count == 0
            boardfull = true
        end
        boardfull
    end   
end

class Match
    include Interface
    
    def play
        boardarray = initialize_boardarray(3, 1)
        winner = false
        boardfull = false
        playerTurn = 0
        symbol = "O"
        welcome()
        while ((winner == false) && (boardfull == false))
            valid_input = false
            if playerTurn % 2 == 0
                symbol = "O"
                puts "it's player1's turn with symbol O"
            else    
                symbol = "X"
                puts "it's player2's turn with symbol X"
            end
            puts ""
            print_board(boardarray)
            while valid_input == false 
                puts "Please enter the number corresponding to the cell where you want to place your #{symbol}"
                choice = gets.chomp
                returnedValues = change_symbol(choice, boardarray, symbol, valid_input)
                classChoice = returnedValues[1]
                valid_input = returnedValues[0]
            end
            winner = check_winner(boardarray, classChoice)
            if winner == true
                print_board(boardarray)
                puts ""
                puts "Congratulations #{symbol} won the match!!!"
            end
            boardfull = check_fullBoard(boardarray)
            playerTurn += 1
        end
    end

    private

    def initialize_boardarray(n, val)
        board = Array.new(n)
        n.times do |row_index|
          board[row_index] = Array.new(n)
          n.times do |column_index|
            board[row_index][column_index] = Cell.new(val.to_s, row_index, column_index)
            val += 1
          end
        end
        board
    end

    def change_symbol(playerChoice, boardarray, symbol, valid_input)
        if playerChoice.to_i.between?(1,9) == false
            puts "You entered a wrong value, please try again"
        else
            boardarray.each do |sub_array|
                sub_array.each do |item|
                    if playerChoice == item.number
                        item.number = symbol
                        playerChoice = item
                        valid_input = true
                    end
                end
            end
        end
        return valid_input, playerChoice
    end


end

match = Match.new()
match.play