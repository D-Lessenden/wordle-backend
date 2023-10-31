class CreateGameHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :game_histories do |t|
      t.integer :games_played, default: 0
      t.integer :one_guess, default: 0
      t.integer :two_guesses, default: 0
      t.integer :three_guesses, default: 0
      t.integer :four_guesses, default: 0
      t.integer :five_guesses, default: 0
      t.integer :six_guesses, default: 0
      t.integer :games_lost, default: 0
      t.integer :games_won, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
