class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.string :target_word, null: false, foreign_key: true
      t.integer :attempts
      t.string :status

      t.timestamps
    end
  end
end
