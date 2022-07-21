class TicTacToe
  @@grid = []

  def initialize
  end

  def create_grid
    @@grid = Array.new(3){Array.new(3, "_")}
    display_grid
  end

  def place_char(char, cell)
    if cell >= 1 && cell <= 3
      row = 0
      cell_adjustment = 1
    elsif cell >= 4 && cell <= 6
      row = 1
      cell_adjustment = 4
    elsif cell >= 7 && cell <= 9
      row = 2
      cell_adjustment = 7
    else
      puts "Invalid input. Please select a value 1-9."
      return
    end

    @@grid[row][cell-cell_adjustment] = char
    display_grid
  end

  def display_grid
    @@grid.each do |row|
      puts row.join(", ").gsub(",", "")
    end
    display_grid_spacer
  end 
  
  def display_grid_spacer
    puts ["", "----------", ""]
  end

end

new_game = TicTacToe.new
new_game.create_grid
new_game.place_char('X', 5)
new_game.place_char('O', 9)

# define players

# method that plays one round
# pars: player/char, cell

# method that draws blank grid / new game