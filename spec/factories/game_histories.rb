FactoryBot.define do 
    factory :game_history do 
        user
        games_played{ 51 }
        games_won { 47 }
        games_lost { 4 }
        six_guesses { 5 }
        five_guesses { 15 }
        four_guesses { 15 }
        three_guesses { 10 }
        two_guesses { 2 }
        one_guess { 0 }
    end
end 