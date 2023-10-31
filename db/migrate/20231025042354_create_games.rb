class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :result
      t.integer :total_guesses, default: 0
      t.string :target_word
      t.references :game_history, null: false, foreign_key: true

      t.timestamps
    end
  end
end
