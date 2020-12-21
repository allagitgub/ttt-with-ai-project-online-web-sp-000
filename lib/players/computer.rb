module Players
  class Computer < Player
    attr_accessor :first_move

    def initialize(token)
      super(token)
      @first_move = true
    end

    def move(board)
      puts "inside computer move"
      if(board.empty? || self.first_move)
        self.first_move = false
        return "5"
      else
        if self.token == "X"
          move = play_strategy("X", "O", board)

        else
          move  = play_strategy("O", "X", board)
        end
      end
    end

    def play_strategy(token, opponent_token, board)
      winning_comb = Game::WIN_COMBINATIONS.find { |item|
        (board.cells[item[0]] == opponent_token && board.cells[item[1]] == opponent_token && board.cells[item[2]] == " ") || (board.cells[item[0]] == opponent_token &&  board.cells[item[2]] == opponent_token && board.cells[item[1]] == " ") ||
        (board.cells[item[1]] == opponent_token &&  board.cells[item[2]] == opponent_token && board.cells[item[0]] == " ")
        }
        if winning_comb == nil
          winning_comb = Game::WIN_COMBINATIONS.find { |item|
          (board.cells[item[0]] == token && board.cells[item[1]] == token && board.cells[item[2]] == " ") || (board.cells[item[0]] == token &&  board.cells[item[2]] == token  && board.cells[item[1]] == " ") ||
          (board.cells[item[1]] == token &&  board.cells[item[2]] == token && board.cells[item[0]] == " ")
          }
        end
        if winning_comb == nil
            puts "there are no two Xs or Os in one row, looking for single my token"
            winning_comb = Game::WIN_COMBINATIONS.find { |item| (!board.taken?(item[0]) || !board.taken?(item[1]) || !board.taken?(item[2])) &&
          (board.cells[item[0]] == token || board.cells[item[1]] == token || board.cells[item[2]] == token)}
        end
        if winning_comb == nil
            puts "there are no two Xs or Os in one row, looking for single"
            winning_comb = Game::WIN_COMBINATIONS.find { |item| (!board.taken?(item[0]) || !board.taken?(item[1]) || !board.taken?(item[2])) &&
          (board.cells[item[0]] == opponent_token || board.cells[item[1]] == opponent_token || board.cells[item[2]] == opponent_token)}
        end
        puts winning_comb.to_s + "winning combination"
        if !board.taken?(winning_comb[0])
          move = index_to_input(winning_comb[0])
          puts "move "+move
          move
        elsif !board.taken?(winning_comb[2])
          move = index_to_input(winning_comb[2])
          puts "move "+move
          move
        else
          move = index_to_input(winning_comb[1])
          puts "move "+move
          move
        end
    end

    def index_to_input(index)
        input = (index + 1).to_s
        input
    end
  end
end
