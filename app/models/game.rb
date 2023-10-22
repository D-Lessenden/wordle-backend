# This model represents individual game instances. It would include fields such as target_word (the word to be guessed), attempts (the number of guesses allowed), status (ongoing, won, or lost), and user_id (if you're implementing user accounts).

class Game < ApplicationRecord
  belongs_to :user
  belongs_to :target_word

  has_one :word, foreign_key: 'target_word_id', class_name: 'Word'
  has_many :guesses, dependent: :destroy

  has_one :game_history

  # Validations
  validates :attempts, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ['ongoing', 'won', 'lost'] }

  # Callback to initialize a new game
  after_initialize :set_game_defaults, if: :new_record?

  # Custom method to check if the game is won
  def won?
    status == 'won'
  end

  # Custom method to check if the game is lost
  def lost?
    status == 'lost'
  end

  private

  # Initialize default game values
  def set_game_defaults
    self.status = 'ongoing'
  end
end

