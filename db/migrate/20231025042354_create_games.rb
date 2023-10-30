class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :attempts
      t.string :status
      t.references :word, null: false, foreign_key: true
      t.references :game_history, null: false, foreign_key: true

      t.timestamps
    end
  end
end
