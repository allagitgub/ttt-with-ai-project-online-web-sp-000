class Game
attr_accessor :board, :player_1, :player_2, :current_player

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]]

  def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
    @next_player = player_1
  end

  def current_player
    turns = self.board.turn_count
    return turns % 2 == 0 ? "X" : "O"
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combination|
      (self.board.cells[win_combination[0]] == "X" && self.board.cells[win_combination[1]] == "X" && self.board.cells[win_combination[2]] == "X") ||
      (self.board.cells[win_combination[0]] == "O" && self.board.cells[win_combination[1]] == "O" && self.board.cells[win_combination[2]] == "O")
   end
  end

  def winner
    if won?
      if( WIN_COMBINATIONS.detect {|win_combination|
        (self.board.cells[win_combination[0]] == "X" && self.board.cells[win_combination[1]] == "X" && self.board.cells[win_combination[2]] == "X") })
        return  "X"
      else
        return "O"
      end
    end
     nil
  end

  def start
  end

  def draw?
    !(won? || !self.board.full?)
  end

  def over?
    won? || self.board.full? || draw?
  end

  def play
    while !over?
          turn
        end
        if won?
          currentwinner = winner
          puts "Congratulations #{currentwinner}!"
        else
          puts "Cat's Game!"
        end
  end

  def turn
    index = next_player.move(board)

    while !self.board.valid_move?(index)
      index = next_player.move(board)

    end
    self.board.update(index, current_player.token)
    if next_player == player_1
      self.current_player = player_2
    else
      self.current_player = player_1
    end
    self.board.display
  end

end
