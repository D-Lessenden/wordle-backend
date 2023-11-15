FactoryBot.define do 
    factory :game do 
        game_history
        result { nil }
        total_guesses { 0 }
        target_word { 'apple' }
        game_board do
            [
              ["", "", "", "", ""],
              ["", "", "", "", ""],
              ["", "", "", "", ""],
              ["", "", "", "", ""],
              ["", "", "", "", ""],
              ["", "", "", "", ""]
            ]
          end
    end 
end 