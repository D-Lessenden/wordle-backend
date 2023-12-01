require 'rails_helper'

RSpec.describe 'GAME API' do
  describe 'happy-paths' do
    it 'can create a game for a user' do 
      create_list(:game_history, 1)
      game_params = {game_history_id: GameHistory.first.id}
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users/#{User.first.id}/game", headers: headers, params: JSON.generate(game_params)

      game = Game.first
      expect(response).to be_successful
      game_json = JSON.parse(response.body, symbolize_names: true)

      expect(game.result).to eq(nil)
      expect(game.target_word.length).to eq(5)
      expect(game.target_word).to be_a(String)

      expect(game_json).to have_key(:id)
      expect(game_json[:id]).to be_an(Integer)

      expect(game_json).to have_key(:game_history_id)
      expect(game_json[:game_history_id]).to be_an(Integer)

      expect(game_json).to have_key(:target_word)
      expect(game_json[:target_word]).to be_an(String)

      expect(game_json).to have_key(:total_guesses)
      expect(game_json[:total_guesses]).to be_an(Integer)
      expect(game_json[:total_guesses]).to eq(0)

      expect(game_json).to have_key(:result)
      expect(game_json[:result]).to eq(nil)
    end 

    it 'can make a game that the user can win' do
      game = create(:game)

      get "/api/v1/users/#{User.first.id}/game/#{game.id}/play"

      expect(response).to be_successful
      inital_board_json = JSON.parse(response.body, symbolize_names: true)

      expect(inital_board_json).to have_key(:game_board)
      expect(inital_board_json[:game_board]).to be_a(Array)
      expect(inital_board_json[:game_board].length).to eq(6)

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'crank' }
      expect(response).to be_successful
      guess1_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess1_json[:game_board][0]).to eq(["c", "r", "a", "n", "k"])

      expect(game.game_history.games_played).to eq(51) 
      expect(game.game_history.two_guesses).to eq(2)
      expect(game.game_history.games_won).to eq(47)

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'apple' }
      expect(response).to be_successful
      guess2_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess2_json).to have_key(:game_history)
      expect(guess2_json[:game_history][:id]).to eq(game.game_history_id)
      expect(guess2_json[:game_history][:games_played]).to eq(52) 
      expect(guess2_json[:game_history][:two_guesses]).to eq(3)
      expect(guess2_json[:game_history][:games_won]).to eq(48)
    end 

    it 'can make a game that the user can lose' do
      game = create(:game)
      get "/api/v1/users/#{User.first.id}/game/#{game.id}/play"

      expect(response).to be_successful
      inital_board_json = JSON.parse(response.body, symbolize_names: true)

      expect(inital_board_json).to have_key(:game_board)
      expect(inital_board_json[:game_board]).to be_a(Array)
      expect(inital_board_json[:game_board].length).to eq(6)

      expect(game.game_history.games_played).to eq(51) 
      expect(game.game_history.games_lost).to eq(4)

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'crank' }
      expect(response).to be_successful
      guess1_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess1_json[:game_board][0]).to eq(["c", "r", "a", "n", "k"])

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'aback' }
      expect(response).to be_successful
      guess2_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess2_json[:game_board][1]).to eq(["a", "b", "a", "c", "k"])

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'assay' }
      expect(response).to be_successful
      guess3_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess3_json[:game_board][2]).to eq(["a", "s", "s", "a", "y"])

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'blurb' }
      expect(response).to be_successful
      guess4_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess4_json[:game_board][3]).to eq(["b", "l", "u", "r", "b"])

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'chafe' }
      expect(response).to be_successful
      guess5_json = JSON.parse(response.body, symbolize_names: true)
      expect(guess5_json[:game_board][4]).to eq(["c", "h", "a", "f", "e"])

      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'craze' }
      expect(response).to be_successful
      guess6_json = JSON.parse(response.body, symbolize_names: true)
      # expect(guess6_json[:game_board][4]).to eq(["c", "r", "a", "z", "e"])

      expect(guess6_json).to have_key(:game_history)
      expect(guess6_json[:game_history][:id]).to eq(game.game_history_id)
      expect(guess6_json[:game_history][:games_played]).to eq(52) 
      expect(guess6_json[:game_history][:games_lost]).to eq(5)

    end 

    it 'user can a game on guesses 1-6' do 
      game1 = create(:game)
      game2 = create(:game)
      game3 = create(:game)
      game4 = create(:game)
      game5 = create(:game)
      game6 = create(:game)

      # game 1 
      patch "/api/v1/users/#{User.first.id}/game/#{game1.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game1_json = JSON.parse(response.body, symbolize_names: true)
      expect(game1_json).to have_key(:game_history)
      expect(game1_json[:game_history][:id]).to eq(game1.game_history_id)
      expect(game1_json[:game_history][:games_played]).to eq(52) 
      expect(game1_json[:game_history][:one_guess]).to eq(1)
      expect(game1_json[:game_history][:games_won]).to eq(48)

      patch "/api/v1/users/#{User.first.id}/game/#{game2.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game3.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game4.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game5.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'crank' }

      # game 2 
      patch "/api/v1/users/#{User.first.id}/game/#{game2.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game2_json = JSON.parse(response.body, symbolize_names: true)
      expect(game2_json).to have_key(:game_history)
      expect(game2_json[:game_history][:id]).to eq(game2.game_history_id)
      expect(game2_json[:game_history][:games_played]).to eq(52) 
      expect(game2_json[:game_history][:two_guesses]).to eq(3)
      expect(game2_json[:game_history][:games_won]).to eq(48)

      patch "/api/v1/users/#{User.first.id}/game/#{game3.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game4.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game5.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'crank' }

      # game 3 
      patch "/api/v1/users/#{User.first.id}/game/#{game3.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game3_json = JSON.parse(response.body, symbolize_names: true)
      expect(game3_json).to have_key(:game_history)
      expect(game3_json[:game_history][:id]).to eq(game3.game_history_id)
      expect(game3_json[:game_history][:games_played]).to eq(52) 
      expect(game3_json[:game_history][:three_guesses]).to eq(11)
      expect(game3_json[:game_history][:games_won]).to eq(48)

      patch "/api/v1/users/#{User.first.id}/game/#{game4.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game5.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'crank' }

      # game 4 
      patch "/api/v1/users/#{User.first.id}/game/#{game4.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game4_json = JSON.parse(response.body, symbolize_names: true)
      expect(game4_json).to have_key(:game_history)
      expect(game4_json[:game_history][:id]).to eq(game4.game_history_id)
      expect(game4_json[:game_history][:games_played]).to eq(52) 
      expect(game4_json[:game_history][:four_guesses]).to eq(16)
      expect(game4_json[:game_history][:games_won]).to eq(48)

      patch "/api/v1/users/#{User.first.id}/game/#{game5.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'crank' }

      # game 5 
      patch "/api/v1/users/#{User.first.id}/game/#{game5.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game5_json = JSON.parse(response.body, symbolize_names: true)
      expect(game5_json).to have_key(:game_history)
      expect(game5_json[:game_history][:id]).to eq(game5.game_history_id)
      expect(game5_json[:game_history][:games_played]).to eq(52) 
      expect(game5_json[:game_history][:five_guesses]).to eq(16)
      expect(game5_json[:game_history][:games_won]).to eq(48)

      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'crank' }

      # game 6 
      patch "/api/v1/users/#{User.first.id}/game/#{game6.id}/play", params: { guess: 'apple' }

      expect(response).to be_successful
      game6_json = JSON.parse(response.body, symbolize_names: true)
      expect(game6_json).to have_key(:game_history)
      expect(game6_json[:game_history][:id]).to eq(game6.game_history_id)
      expect(game6_json[:game_history][:games_played]).to eq(52) 
      expect(game6_json[:game_history][:six_guesses]).to eq(6)
      expect(game6_json[:game_history][:games_won]).to eq(48)

    end 

    it "can process invalid responses properly" do 
      game = create(:game)
      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'crank' }
      patch "/api/v1/users/#{User.first.id}/game/#{game.id}/play", params: { guess: 'aaa' }
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to have_key(:message)
      expect(json).to have_key(:game_board)
      expect(json[:message]).to eq("Please enter a valid 5 letter word.")
      expect(json[:game_board]).to eq([["c", "r", "a", "n", "k"], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""], ["", "", "", "", ""]])
    end 
  end
end