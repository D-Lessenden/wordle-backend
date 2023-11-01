# This model represents individual game instances. It would include fields such as target_word (the word to be guessed), attempts (the number of guesses allowed), status (ongoing, won, or lost), and user_id (if you're implementing user accounts).

class Game < ApplicationRecord
  belongs_to :game_history
  belongs_to :user


  # Callback to initialize a new game
  # after_initialize :set_game_defaults, if: :new_record?

  # Custom method to check if the game is won
  # def won?
  #   status == 'won'
  # end

  # Custom method to check if the game is lost
  # def lost?
  #   status == 'lost'
  # end

  private

  # Initialize default game values
  # def set_game_defaults
  #   self.status = 'ongoing'
  # end
end




# # This model represents the words that players will try to guess. It may include fields like word (the actual word to be guessed) and word_length (the length of the word). You would need to populate this model with a list of valid words for the game.

# # need a dictionary of wordle words 
# # app/models/word.rb

# class Word < ApplicationRecord
#   # Validations
#   validates :word, presence: true, uniqueness: true
#   # validates :word_length, presence: true, numericality: { greater_than: 0 }

#   # Associations
#   has_many :games, foreign_key: 'word_id', class_name: 'Game'

#   def select_word
#     @game.target_word = WordService.random_word
#   end 

#   # Custom validation to ensure uniqueness of word_length
#   # validate :unique_word_length, on: :create

#   # # Custom validation to ensure word_length is consistent
#   # def unique_word_length
#   #   return if Word.where(word_length: word_length).exists?

#   #   errors.add(:word_length, "must be unique")
#   # end
# end

# #   The Word model represents words and includes fields for the word itself (word) and its length (word_length).

# # It contains validations to ensure the word is present, unique, and that the word length is a positive number.

# # It's associated with the Game model, indicating that a word can be the target word in multiple games.

# # You can adjust the validations and associations to fit your specific requirements. Depending on your Wordle clone's features, you may need to add more fields or associations. This basic model provides a starting point, and you can customize it according to your needs.

# This model represents the guesses made by players during a game. Fields may include word (the guessed word) and a reference to the associated game (e.g., game_id).
# class Guess < ApplicationRecord
#   belongs_to :game
#   validates :letter, presence: true, length: { is: 1 }


#     def check_guess(guess, target_word)
#       return nil unless guess.length == target_word.length

#       result = []
      
#       guess.each_char.with_index do |letter, index|
#         if letter == target_word[index]
#           result << "correct"
#         elsif target_word.include?(letter)
#           result << "in word"
#         else
#           result << "incorrect"
#         end
#       end
#       result
#     end
#   end