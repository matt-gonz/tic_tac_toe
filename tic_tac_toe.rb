class TicTacToe
  @@grid = []

  def initialize
    @players = []
  end

  # create blank grid and calls display_grid method
  def create_grid
    @@grid = Array.new(3){Array.new(3, "_")}
    display_grid
  end

  # places character in specified grid cell 1-9
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

  # display current grid state, neatly formatted
  # in three rows
  def display_grid
    @@grid.each do |row|
      puts row.join(", ").gsub(",", "")
    end
    display_grid_spacer
  end 
  
  def display_grid_spacer
    puts ["", "----------", ""]
  end

  def add_player(is_player2 = false)
    if is_player2 == false
      puts "Player 1, please input your name: "
      name = gets.chomp()
      puts "Welcome #{name}, please select either X or O: "
      character = gets.chomp() 
    else
      puts "Player 2, please input your name: "
      name = gets.chomp()
      if @players[0].character == 'X'
        character = 'O'
      elsif @players[0].character == 'O'
        character = 'X'
      end
      puts "Welcome #{name}, your symbol for this game is #{character}." 
    end     
      
    @players.push(Player.new(name, character))
  end

  def start_game
    add_player
    add_player(isPlayer2=true)
    create_grid
    no_winner = true
    loop do
      # player1's turn 
      puts "#{@players[0].name}, please select a cell 1-9."
      cell_player1 = gets.chomp().to_i
      place_char(@players[0].character, cell_player1)
      # logic to check for winner
      if (@@grid[0].all? {|c| c == "X" || c == "O"} || @@grid[1].all? {|c| c == "X" || c == "O"} || @@grid[2].all? {|c| c == "X" || c == "O"})
        no_winner = false
        puts "There was a winner"
      end
      # player2's turn
      puts "#{@players[1].name}, please select a cell 1-9."
      cell_player2 = gets.chomp().to_i
      place_char(@players[1].character, cell_player2)

      break if no_winner == false
    end
  end

end

class Player < TicTacToe
  def initialize(name, character)
    @name = name
    @character = character
  end

  def name
    @name
  end

  def character
    @character
  end

end

new_game = TicTacToe.new
new_game.start_game