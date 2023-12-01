require 'rails_helper'

RSpec.describe 'GAME HISTORY API' do
  describe 'happy-paths' do
    it 'can return a users game history' do
        game_history = create(:game_history)

        get "/api/v1/users/#{User.first.id}/game_history/#{game_history.id}"

        expect(response).to be_successful 

        json = JSON.parse(response.body, symbolize_names: true)
        game_history = json

        expect(game_history).to have_key(:games_won)
        expect(game_history[:games_won]).to be_an(Integer)

        expect(game_history).to have_key(:games_lost)
        expect(game_history[:games_lost]).to be_an(Integer)
        
        expect(game_history).to have_key(:six_guesses)
        expect(game_history[:six_guesses]).to be_an(Integer)
    
        expect(game_history).to have_key(:five_guesses)
        expect(game_history[:five_guesses]).to be_an(Integer)
        
        expect(game_history).to have_key(:four_guesses)
        expect(game_history[:four_guesses]).to be_an(Integer)
        
        expect(game_history).to have_key(:three_guesses)
        expect(game_history[:three_guesses]).to be_an(Integer)
        
        expect(game_history).to have_key(:two_guesses)
        expect(game_history[:two_guesses]).to be_an(Integer)
    
        expect(game_history).to have_key(:one_guess)
        expect(game_history[:one_guess]).to be_an(Integer)
    end 

    it 'can create a game history for user' do
      create_list(:user, 1)
      gh_params = {user_id: User.first.id}
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users/#{User.first.id}/game_history", headers: headers, params: JSON.generate(gh_params)

      created_gh = GameHistory.first

      expect(response).to be_successful
      expect(created_gh.games_played).to eq(0)
      expect(created_gh.one_guess).to eq(0)
      expect(created_gh.two_guesses).to eq(0)
      expect(created_gh.three_guesses).to eq(0)
      expect(created_gh.four_guesses).to eq(0)
      expect(created_gh.five_guesses).to eq(0)
      expect(created_gh.six_guesses).to eq(0)
      expect(created_gh.games_lost).to eq(0)
      expect(created_gh.games_won).to eq(0)
      expect(created_gh.user_id).to eq(User.first.id)
    end
  end

  describe 'sad-paths' do
    it 'show - returns a 204 if game_history table is empty' do
      create_list(:user, 5)
      # binding.pry
      get "/api/v1/users/#{User.first.id}/game_history/9999"
      expect(response).to be_successful
      expect(response.status).to eq(204)
    end

    # it 'show - returns a 204 if query entered wrong' do
    #   get '/api/v1/users/99999/game_history/99999'
    #   expect(response).to be_successful
    #   expect(response.status).to eq(204)
    # end
  end
end