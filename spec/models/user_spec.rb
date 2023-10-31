require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :username}
    it {should validate_uniqueness_of :username}
    it {should validate_presence_of :password}
    it {should validate_presence_of :password_confirmation}
    it {should have_many(:games)}
    it {should have_one(:game_history)}
  end 

  it 'can create a user' do 
    user_params = {
      username: "user1", 
      email: "user1@example.com", 
      password: "password1", 
      password_confirmation: "password1"
      }
   

  new_user = User.create(user_params)

  expect(new_user.email).to eq('user1@example.com')
  expect(new_user.username).to eq('user1')
  end
end
