#This model is required if you want to implement user accounts and save user-specific game progress and scores. It would typically include fields like username, email, and password.
class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true
    validates :password, presence: true, if: :new_record?
    validates :password_confirmation, presence: true, if: :new_record?
    validates_uniqueness_of :email
    validates :username, presence: true
    validates_uniqueness_of :username
    
    has_one :game_history
    has_many :games, through: :game_history
end 