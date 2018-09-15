require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do
    subject(:chris) { User.new(username: '_Chris', password: "starwars")}
      it {should validate_presence_of(:username)}
      it {should validate_presence_of(:password_digest)}
      it {should validate_presence_of(:session_token)}
      it {should validate_uniqueness_of(:username) }
      it {should validate_uniqueness_of(:session_token) }
      it {should validate_length_of(:password).is_at_least(6)}
  end
  
  describe '#password=(password)' do
    it 'use BCrypt to create password_digest' do
      expect(BCrypt::Password).to receive(:create).with('starwars')
      User.new(username: '_Chris', password: "starwars")
    end
    
    it "shouldn't save password into database"  do
      User.create(username: '_Chris', password: "starwars")
      user = User.find_by(username: '_Chris')
      expect(user.password).not_to be('starwars')
    end
  end
  
  describe 'session_token' do
    subject(:chris) { User.new(username: '_Chris', password: "starwars")}
    
    it 'ensure session_token when not given' do
      expect(chris.session_token).not_to eq(nil)
    end
    
    it 'reset session_token' do
      old = chris.session_token
      chris.reset_session_token!
      expect(chris.session_token).not_to eq(old)
    end
  end
  
  describe '::find by credentials' do
    it 'should return user if given valid credentials' do
      user = User.create(username: '_Chris', password: "starwars")
      expect(User.find_by_credentials('_Chris','starwars')).to eq(user)
    end
      
    it 'should return nil if given invalid credentials' do
      user = User.create(username: '_Chris', password: "starwars")
      expect(User.find_by_credentials('_Chris','')).to eq(nil)
    end
    
  end
  
end
