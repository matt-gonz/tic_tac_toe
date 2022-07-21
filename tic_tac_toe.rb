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
  def place_char(char, cell, row, row_adjustment)
    if row_adjustment
      @@grid[row][cell-row_adjustment] = char
      display_grid
    else
      puts "Invalid input. Please select a value 1-9."
      return
    end
  end

  # check if cell has already been played
  def cell_played?(cell, row, row_adjustment)
    if row_adjustment
      selected_cell = @@grid[row][cell-row_adjustment]
      if selected_cell == "_"
        return false
      else 
        return true
      end
    else
      return "invalid"
    end
  end

  # get row offset depending of cell selection
  def get_row_adjustment(cell)
    if cell >= 1 && cell <= 3
      row = 0
      row_adjustment = 1
    elsif cell >= 4 && cell <= 6
      row = 1
      row_adjustment = 4
    elsif cell >= 7 && cell <= 9
      row = 2
      row_adjustment = 7
    else
      return nil
    end

    return [row, row_adjustment]
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

  # add player to @players instance var
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
      selected_cell = get_player_cell_input(@players[0])
      loop do 
        if selected_cell != nil && selected_cell != "invalid"
          place_char(@players[0].character, selected_cell[0], selected_cell[1], selected_cell[2])
          turn_count += 1
          break
        elsif selected_cell == "invalid"
          message = "Invalid input. Please select a value 1-9."
          selected_cell = get_player_cell_input(@players[0], message)
        else
          message = "Cell has already been played. Please select another cell 1-9."
          selected_cell = get_player_cell_input(@players[0], message)
        end
      end
        
      # check for winner if at least 5 turns have been played
      if turn_count >= 5
        no_winner = check_for_winner
        break if no_winner == false
      end

      # player2's turn 
      selected_cell = get_player_cell_input(@players[1])
      loop do 
        if selected_cell != nil && selected_cell != "invalid"
          place_char(@players[1].character, selected_cell[0], selected_cell[1], selected_cell[2])
          turn_count += 1
          break
        elsif selected_cell == "invalid"
          message = "Invalid input. Please select a value 1-9."
          selected_cell = get_player_cell_input(@players[1], message)
        else
          message = "Cell has already been played. Please select another cell 1-9."
          selected_cell = get_player_cell_input(@players[1], message)
        end
      end

      if turn_count >= 5
        no_winner = check_for_winner
        break if no_winner == false
      end
    end
  end

  def get_player_cell_input(player = @players[0], message = "")
    name = player.name
    character = player.character
    if message == ""
      puts "#{name}, please select a cell 1-9."
    else
      puts message
    end
    cell = gets.chomp().to_i
    row_adjust = get_row_adjustment(cell)
    cell_played = cell_played?(cell, row_adjust[0], row_adjust[1])
    # only return selected cell if it has not already been played
    if cell_played == false
      return [cell, row_adjust[0], row_adjust[1]]
    elsif cell_played == "invalid"
      return "invalid"
    else
      return nil  
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