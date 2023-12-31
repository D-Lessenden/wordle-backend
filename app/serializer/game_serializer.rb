class GameSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :result, :total_guesses, :target_word, :game_board

    belongs_to :game_history
    # belongs_to :user
end 