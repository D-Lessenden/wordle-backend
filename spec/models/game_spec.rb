require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'Validations' do
    it {should belong_to :game_history}
  end 

  it "should set defaults to 0 when initialized" do 
    user = User.create(username: "user1", email: "user1@email.com", password: "12345", password_confirmation: "12345")
    game_history = GameHistory.new(user: user)
    game = Game.create(game_history: game_history)

    expect(game.total_guesses).to eq(0)
  end 
end
