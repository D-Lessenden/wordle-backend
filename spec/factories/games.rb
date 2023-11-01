FactoryBot.define do 
    factory :game do 
        game_history
        result { 'Win' }
        total_guesses { 5 }
        target_word { 'Apple '}
    end 
end 