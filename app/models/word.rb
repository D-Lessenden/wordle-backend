# This model represents the words that players will try to guess. It may include fields like word (the actual word to be guessed) and word_length (the length of the word). You would need to populate this model with a list of valid words for the game.

# need a dictionary of wordle words 
# app/models/word.rb

class Word < ApplicationRecord
    # Validations
    validates :word, presence: true, uniqueness: true
    validates :word_length, presence: true, numericality: { greater_than: 0 }
  
    # Associations
    has_many :games, foreign_key: 'target_word_id', class_name: 'Game'
  
    # Custom validation to ensure uniqueness of word_length
    validate :unique_word_length, on: :create
  
    # Custom validation to ensure word_length is consistent
    def unique_word_length
      return if Word.where(word_length: word_length).exists?
  
      errors.add(:word_length, "must be unique")
    end
  end

#   The Word model represents words and includes fields for the word itself (word) and its length (word_length).

# It contains validations to ensure the word is present, unique, and that the word length is a positive number.

# It's associated with the Game model, indicating that a word can be the target word in multiple games.

# You can adjust the validations and associations to fit your specific requirements. Depending on your Wordle clone's features, you may need to add more fields or associations. This basic model provides a starting point, and you can customize it according to your needs.
  