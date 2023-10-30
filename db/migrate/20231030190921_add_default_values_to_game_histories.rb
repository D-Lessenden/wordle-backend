class AddDefaultValuesToGameHistories < ActiveRecord::Migration[7.0]
  def change
    change_column_default :game_histories, :games_completed, 0
    change_column_default :game_histories, :one_guess, 0
    change_column_default :game_histories, :two_guesses, 0
    change_column_default :game_histories, :three_guesses, 0
    change_column_default :game_histories, :four_guesses, 0
    change_column_default :game_histories, :five_guesses, 0
    change_column_default :game_histories, :six_guesses, 0
    change_column_default :game_histories, :failed, 0
  end
end
