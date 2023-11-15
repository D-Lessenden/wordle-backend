require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Validations' do
    it {should belong_to :game_history}
    # it {should belong_to :user}
  end 

  it "should set defaults to 0 when initialized and generate a 5 letter word" do 
    user = User.create!(email: 'user@test.com', password: 'password', password_confirmation: 'password')
    game_history = GameHistory.create(user: user)
    target_word = GameService.random_word
    game = Game.create(game_history_id: game_history.id, target_word: target_word)

    expect(game.total_guesses).to eq(0)
    expect(game.target_word.length).to eq(5)
  end 
end
