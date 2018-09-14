require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe User do
    
    subject(:user) do
      FactoryBot.build(:user,
      username: "jonathan@fakesite.com",
      password: "good_password")
    end
    
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    
    it { should validate_length_of(:password).is_at_least(6) } 
  end
end
