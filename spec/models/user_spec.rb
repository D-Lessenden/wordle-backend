require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :provider}
    it {should validate_presence_of :token}
    it {should validate_presence_of :uid}
  end 

  describe 'relationships' do 
    it {should have_one(:game_history)}
    it {should have_many(:games).through(:game_history)}
  end 

  describe 'creation' do 
    it 'can make a new user' do 
      User.create!(email: 'user@test.com', provider: 'google', token: '1234', uid: '98765')
      expect(User.count).to eq(1)
    end 
  end 

  # describe 

  # it 'can create a user' do 
  #   user_params = {
  #     username: "user1", 
  #     email: "user1@example.com", 
  #     password: "password1", 
  #     password_confirmation: "password1"
  #     }
   

  # new_user = User.create(user_params)

  # expect(new_user.email).to eq('user1@example.com')
  # expect(new_user.username).to eq('user1')
  # end
end
