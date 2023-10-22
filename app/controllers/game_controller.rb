class GameController < ApplicationController
    def new
        @game = Game.new
        # valid_words = WordImportService.import_words_from_file('path_to_your_word_list.txt')
        # random_word = valid_words.sample
        @game.target_word = WordService.random_word
      # Additional game setup logic
    end

    def won_game
      if @game.status == 'won'
        GameHistory.create(
          user: current_user, # If you have user authentication
          target_word: @game.target_word,
          status: 'won'
        )
      end
    end 
  
    # Other controller actions
end