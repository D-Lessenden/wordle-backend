class CreateGameHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :game_histories do |t|
      t.string :target_word
      t.string :status
      t.integer :games_completed
      t.integer :one_guess
      t.integer :two_guesses
      t.integer :three_guesses
      t.integer :four_guesses
      t.integer :five_guesses
      t.integer :six_guesses
      t.integer :failed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
