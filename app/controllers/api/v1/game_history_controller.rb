class Api::V1::GameHistoryController < ApplicationController
    def create
        user = User.find(params[:user_id])
        game_history = GameHistory.new(game_history_params)
        game_history.user = user
    
        if game_history.save
          render json: game_history, status: :created
        else
          render json: { errors: game_history.errors.full_messages }, status: :unprocessable_entity
        end
      end

    def show
        user = User.find(params[:user_id])
        game_history = GameHistory.find_by(id: params[:id])

        if game_history
            render json: game_history, serializer: GameHistorySerializer
        else
            head :no_content
        end
    end

    private
  
    def game_history_params
      params.require(:game_history).permit(:games_played, :one_guess, :two_guesses, :three_guesses, :four_guesses, :five_guesses, :six_guesses, :games_lost, :games_won)
    end
end 

        # Implement the logic to retrieve a specific game history
        # user = User.find(params[:user_id])
        # game_history = GameHistory.find(params[:id])
        # render json: game_history