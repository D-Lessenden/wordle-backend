require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :password}
    it {should validate_presence_of :password_confirmation}
    it {should have_many(:games)}
    it {should have_many(:game_histories)}
  end 

  # new_user = User.create(user_params)
  # expect(new.user.email).to eq("example@email.com")
  #expect to have games 
end
