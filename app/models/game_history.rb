class GameHistory < ApplicationRecord
  has_many :games
  belongs_to :user

  # def total_wins
  #   games.where(status: "won").count
  # end

  # def total_losses
  #   games.where(status: "lost").count
  # end
end
