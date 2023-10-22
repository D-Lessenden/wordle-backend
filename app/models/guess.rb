# This model represents the guesses made by players during a game. Fields may include word (the guessed word) and a reference to the associated game (e.g., game_id).
class Guess < ApplicationRecord
  # Associations
  belongs_to :game

  # Validations
  validates :word, presence: true
  validate :validate_word_length, on: :create

  def validate_word_length
      return unless game 

      unless word.length == game.target_word.length 
          errors.add(:word, "Must be exactly 5 letters long!")
      end 
    end
end 