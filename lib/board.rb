class Board
  attr_accessor :cells
  def initialize
    reset!
  end

  def reset!
    if self.cells != nil
      self.cells.clear
    end
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} "+"|"+" #{@cells[1]} "+"|"+" #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} "+"|"+" #{@cells[4]} "+"|"+" #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} "+"|"+" #{@cells[7]} "+"|"+" #{@cells[8]} "
  end

  def position(index)
    if index.class == String
      i = input_to_index(index)
      self.cells[i]
    else
        self.cells[index]
    end

  end

  def input_to_index(input)
    index = input.to_i
    index - 1
  end

  def update(position, player)
    if position.class == String
      i = input_to_index(position)
      self.cells[i]=player.token
    else
        self.cells[position]=player.token
    end
  end

  def full?
    @cells.select{ |item| item != " " && !item.nil? && item != ""}.size == 9
  end

  def turn_count
    count = 0
    @cells.each do  |item|
      if !(item == " " || item == "" )
        count += 1
      end
    end
    count
  end

  def taken?(input)
    puts input.to_s + "taken?"
    puts position(input) == "X" || position(input) == "O"
    position(input) == "X" || position(input) == "O"
  end
  def valid_move?(input)
    input != nil && (Float(input) rescue false) && input.to_i.between?(1,9) && !taken?(input)
  end

  def empty?
    found_item = self.cells.find { |item| item != " " && item != nil}
    if found_item == nil
      return true
    else
      return false
    end
  end

end
