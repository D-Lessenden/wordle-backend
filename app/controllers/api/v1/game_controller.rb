class Api::V1::GameController < ApplicationController
  before_action :load_word_list

  def create
    user = User.find(params[:user_id])
    game_history = user.game_history

    @game = game_history.games.create(target_word: GameService.random_word)

    if @game.save
      initialize_game_board
      render json: @game, status: :created
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def play
    @game = Game.find(params[:id])

    if request.get?
      render_game_board 
    elsif request.patch?
      user_guess = params[:guess]

      if valid_guess?(user_guess)
        handle_guess(user_guess)
      else
        render json: { message: "Please enter a valid 5 letter word.", game_board: @game.game_board }
      end 
    else 
      render json: { message: "Invalid request method." }
    end 
  end 

  private 

  def initialize_game_board
    @game.game_board = Array.new(6) { Array.new(5, "") }
    # @game.game_board2 = Array.new(6) { Array.new(5, "") }
    @game.save
  end

  def load_word_list
    @word_list = File.read(Rails.root.join("public/word_list.txt")).split("\n")
  end

  def valid_guess?(user_guess)
    @word_list.include?(user_guess)
  end

  def handle_guess(user_guess)
    i = @game.total_guesses
    @game.game_board[i] = user_guess.chars
    @game.total_guesses += 1
    if user_guess == @game.target_word 
      @game.result = 'Win'
      @game.save
      update_game_history
      render json: { game_history: @game.game_history }
    elsif @game.total_guesses == 6 
      @game.result = "Loss"
      @game.save 
      update_game_history
      render json: { game_history: @game.game_history }
    else 
      @game.save
      render_game_board 
    end
  end 

  def render_game_board 
    render json: { game_board:  @game.game_board }
  end

  def update_game_history
    # Update the game history with the result and total_guesses
    game_history = @game.game_history
    
    case @game.result
    when "Win"
      game_history.games_won += 1
    when "Loss"
      game_history.games_lost += 1
    end
    
    game_history.games_played += 1 if @game.result == "Win" || @game.result == "Loss"
    
    case @game.total_guesses
    when 1 
      game_history.one_guess += 1
    when 2
      game_history.two_guesses += 1
    when 3
      game_history.three_guesses += 1
    when 4
      game_history.four_guesses += 1
    when 5
      game_history.five_guesses += 1
    when 6
      game_history.six_guesses += 1
    end
    game_history.save
  end
end 


  # def process_valid_guess(user_guess)
  #   if @game.total_guesses.zero? && @game.result.nil?
  #     # Initialize the game board with 6 rows of empty squares
  #     initialize_game_board
  #     render_game_board(["Make your first guess!"], "white")
  #   else
  #     handle_guess(user_guess)
  #   end
  # end

