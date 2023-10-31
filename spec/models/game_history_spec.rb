require 'rails_helper'

RSpec.describe GameHistory, type: :model do
  describe "is valid with valid attributes" do
    it {should belong_to :user}
  end

  it 'should set defaults to 0 when initialized' do 
    user = User.create(username: "user1", email: "user1@email.com", password: "12345", password_confirmation: "12345")
    game_history = GameHistory.new(user: user)

    expect(game_history.games_played).to eq(0)
    expect(game_history.one_guess).to eq(0)
    expect(game_history.two_guesses).to eq(0)
    expect(game_history.three_guesses).to eq(0)
    expect(game_history.four_guesses).to eq(0)
    expect(game_history.five_guesses).to eq(0)
    expect(game_history.six_guesses).to eq(0)
    expect(game_history.games_lost).to eq(0)
    expect(game_history.games_won).to eq(0)
  end 
  # it "is not valid without a target word" do
  #   game_history = GameHistory.new(user: nil, target_word: nil, status: "won")
  #   expect(game_history).to_not be_valid
  # end
end

# 