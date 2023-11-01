class Api::V1::GameController < ApplicationController
    def create
        # target_word = GameService.random_word
        # # @game = Game.create!(game_params)
        # @game = Game.create!(target_word: target_word)
        # @game.target_word = GameService.random_word
        @game = Game.create(target_word: GameService.random_word)
    end
  end 
end 