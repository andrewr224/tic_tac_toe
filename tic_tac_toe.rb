# Define the game. Everything is inside this class
class Game
  attr_accessor :board, :over, :win_combos
  def initialize()
    @board = ["-1-", "-2-", "-3-", "-4-", "-5-", "-6-", "-7-", "-8-", "-9-"]
    @player_x = Player.new("X")
    @player_o = Player.new("O")
    @boxes = [1,2,3,4,5,6,7,8,9]
    @over = false
    @win_combos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    play
  end
  
  # Shows playing board
  def show_board
    puts @board[0..2].join('')
    puts @board[3..5].join('')
    puts @board[6..8].join('')
  end
  
  # Checks if any of the players have won
  def victory(player)
    # win_combos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    if @win_combos.any? { |combo| combo.all? { |e| player.score.include?(e) }}
      puts "Player #{player.char} is victorious!"
      show_board
      @over = true
    elsif @boxes.empty?
      @over = true
      puts "It's a draw."
      show_board
    end
  end
  
  # Define player class that stores player character and score of occupied boxes
  class Player
    attr_accessor :char, :score
    def initialize(char)
      @char = char
      @score = []
    end
  end
  
  # This is how the game is played
  def play
    unless self.over
      if @boxes.length % 2 == 0
        player = @player_o
      else
        player = @player_x
      end
      
      show_board
      input = gets.chomp.to_i
      
      if [1,2,3,4,5,6,7,8,9].any? { |e| e == input }
        if @boxes.any? { |e| e == input }
          @board[input - 1] = "-#{player.char}-"
          player.score << input
          @boxes.delete(input)
          
          victory(player)
        else
          puts "This box is occupied. Try another one"
          play
        end
      else
        puts "Input error, try again"
        play
      end
      play
    end
  end
end