class GameHistorySerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :games_played, :games_won, :games_lost, :six_guesses, :five_guesses, :four_guesses, :three_guesses, :two_guesses, :one_guess
    
    belongs_to :user
  end