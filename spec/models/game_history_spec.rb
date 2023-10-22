require 'rails_helper'

RSpec.describe GameHistory, type: :model do
  it "is valid with valid attributes" do
    game_history = GameHistory.new(user: nil, target_word: "example", status: "won")
    expect(game_history).to be_valid
  end

  it "is not valid without a target word" do
    game_history = GameHistory.new(user: nil, target_word: nil, status: "won")
    expect(game_history).to_not be_valid
  end
end
