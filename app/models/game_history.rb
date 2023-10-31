class GameHistory < ApplicationRecord
  belongs_to :user
  has_many :games

  # def total_wins
  #   games.where(status: "won").count
  # end

  # def total_losses
  #   games.where(status: "lost").count
  # end
end
