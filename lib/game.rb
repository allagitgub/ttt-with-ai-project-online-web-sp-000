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
    @current_player = player_1
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
    puts "Welcome to Tic Tac Toe"
    play_again = "yes"
    while play_again == "yes"
      puts "What kind of game would you like to play, (please enter 0 for 0 human players, 1 for 1 human player, 2 for 2 human players or wargames for computer games)"
      input = gets.chomp
      while input != "0" && input != "1" && input != "2" && input != "wargames"
        puts "What kind of game would you like to play, (please enter 0, 1, 2 or wargames)"
        input = gets.chomp
      end
      if input == "0"
        player_1 = Players::Computer.new("X")
        player_2 =  Players::Computer.new("O")
      elsif input == "1"
        puts "Do you want to go first? (type yes or no)"
        yes_no = gets.chomp
        while yes_no != "yes" && yes_no != "no"
          puts "Do you want to go first? (type yes or no)"
          yes_no = gets.chomp
        end
        if yes_no == "yes"
          player_1 = Players::Human.new("X")
          player_2 = Players::Computer.new("O")
        elsif yes_no == "no"
          player_1 = Players::Computer.new("X")
          player_2 = Players::Human.new("O")
        end
      elsif input == "2"
        player_1 = Players::Human.new("X")
        player_2 = Players::Human.new("O")
      elsif input == "wargames"
        player_1 = Players::Computer.new("X")
        player_2 =  Players::Computer.new("O")
      end
      board = Board.new
      game = Game.new(player_1, player_2, board)
      if(input != "wargames")
        game.play
      else
        won_counter = 0
        100.times do
          board.reset!
          player_1 = Players::Computer.new("X")
          player_2 =  Players::Computer.new("O")
          game = Game.new(player_1, player_2, board)
          game.play
          if game.won?
            won_counter +=1
          end
        end
        puts "Number of games won = "+ won_counter.to_s
      end
      puts "Would you like to play again? (please type yes or no)"
      play_again = gets.chomp
    end
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
    index = self.current_player.move(board)

    while !self.board.valid_move?(index)
      puts "invalid move loop"
      index = self.current_player.move(board)
    end
    puts "got out of the invalid loop"
    puts "about to update the board with index "+ index.to_s
    self.board.update(index, current_player)
    puts current_player.to_s + "current player"
    if self.current_player == player_1
      self.current_player = player_2
    else
      self.current_player = player_1
    end
    self.board.display
  end

end
