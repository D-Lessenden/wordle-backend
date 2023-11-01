#This model is required if you want to implement user accounts and save user-specific game progress and scores. It would typically include fields like username, email, and password.
class User < ApplicationRecord
    validates :email, :provider, :token, :uid, presence: true
    validates_uniqueness_of :email
    
    has_one :game_history
    has_many :games, through: :game_history

    def self.exist?(id)
        find(id) rescue false 
    end 

    def self.from_onmiauth(user_params)
        user = find_or_create_by(uid: user_params[:uid])
        user.email = user_params[:email]
        user.provider = user_params[:provider]
        user.token = user_params[:token]
        user.refresh_token = user_params[:refresh_token]
        user.save
        user
    end 
end 