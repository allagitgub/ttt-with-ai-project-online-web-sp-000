module Players
  class Computer < Player

    def move(board)
      if(board.empty?)
        return 4
      else
        if self.token == "X"
            winning_comb = Game::WIN_COMBINATIONS.find { |item| !board.taken?(item[0]) || !board.taken?(item[1]) || !board.taken?(item[2]) &&
              item[0] != "O" && item[1] != "O" && item[2] != "O"
              }
              winning_comb[0]
        else
          winning_comb = Game::WIN_COMBINATIONS.find { |item| !board.taken?(item[0]) || !board.taken?(item[1]) || !board.taken?(item[2]) &&
            item[0] == "O" || item[1] == "O" || item[2] == "O"
            }
            move = winning_comb.find {|index| winning_comb[index] == " " }
            move
        end
      end
    end
  end
end
