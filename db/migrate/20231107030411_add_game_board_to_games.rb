class AddGameBoardToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :game_board, :json, default: []
  end
end
