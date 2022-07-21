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
      character = gets.chomp().capitalize()
      loop do
        if character == "X" || character == "O"
          break
        else
          puts "Invalid input. Please select either X or O: "
          character = gets.chomp().capitalize()
        end
      end
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
    turn_count = 0
    loop do
      # player1's turn 
      puts "#{@players[0].name}, please select a cell 1-9."
      cell_player1 = gets.chomp().to_i
      place_char(@players[0].character, cell_player1)
      turn_count += 1
      # check for winner if at least 5 turns have been played
      if turn_count >= 5
        no_winner = check_for_winner
        break if no_winner == false
      end
      # player2's turn
      puts "#{@players[1].name}, please select a cell 1-9."
      cell_player2 = gets.chomp().to_i
      place_char(@players[1].character, cell_player2)
      turn_count += 1
      if turn_count >= 5
        no_winner = check_for_winner
        break if no_winner == false
      end

      break if no_winner == false
    end
  end

  def check_for_winner
    no_winner = true
    diagonal_win = [@@grid[0].first, @@grid[1][1], @@grid[2].last]
    backwards_diagonal_win = [@@grid[0].last, @@grid[1][1], @@grid[2].first]
    left_vertical_win = [@@grid[0].first, @@grid[1].first, @@grid[2].first]
    center_vertical_win = [@@grid[0][1], @@grid[1][1], @@grid[2][1]]
    right_vertical_win = [@@grid[0].last, @@grid[1].last, @@grid[2].last]
    # check if player 1 won
    if (@@grid[0].all? {|c| c == @players[0].character} || @@grid[1].all? {|c| c == @players[0].character} || @@grid[2].all? {|c| c == @players[0].character})
      puts "#{@players[0].name} won!"
      no_winner = false
    elsif diagonal_win.all? {|c| c != "_"} && diagonal_win.all? {|c| c == @players[0].character}
      puts "#{@players[0].name} won diagonally!"
      no_winner = false
    elsif backwards_diagonal_win.all? {|c| c != "_"} && backwards_diagonal_win.all? {|c| c == @players[0].character}
      puts "#{@players[0].name} won backwards diagonally!"
      no_winner = false
    elsif left_vertical_win.all? {|c| c!= "_"} && left_vertical_win.all? {|c| c == @players[0].character}
      puts "#{@players[0].name} won vertically!"
      no_winner = false
    elsif center_vertical_win.all? {|c| c!= "_"} && center_vertical_win.all? {|c| c == @players[0].character}
      puts "#{@players[0].name} won vertically!"
      no_winner = false
    elsif right_vertical_win.all? {|c| c!= "_"} && right_vertical_win.all? {|c| c == @players[0].character}
      puts "#{@players[0].name} won vertically!"
      no_winner = false
    end

    # check if player 2 won
    if (@@grid[0].all? {|c| c == @players[1].character} || @@grid[1].all? {|c| c == @players[1].character} || @@grid[2].all? {|c| c == @players[1].character})
      puts "#{@players[1].name} won!"
      no_winner = false
    elsif diagonal_win.all? {|c| c != "_"} && diagonal_win.all? {|c| c == @players[1].character}
      puts "#{@players[1].name} won diagonally!"
      no_winner = false
    elsif backwards_diagonal_win.all? {|c| c != "_"} && backwards_diagonal_win.all? {|c| c == @players[1].character}
      puts "#{@players[1].name} won backwards diagonally!"
      no_winner = false
    elsif left_vertical_win.all? {|c| c!= "_"} && left_vertical_win.all? {|c| c == @players[1].character}
      puts "#{@players[1].name} won vertically!"
      no_winner = false
    elsif center_vertical_win.all? {|c| c!= "_"} && center_vertical_win.all? {|c| c == @players[1].character}
      puts "#{@players[1].name} won vertically!"
      no_winner = false
    elsif right_vertical_win.all? {|c| c!= "_"} && right_vertical_win.all? {|c| c == @players[1].character}
      puts "#{@players[1].name} won vertically!"
      no_winner = false
    end

    return no_winner
  end

end

class Player
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