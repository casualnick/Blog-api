require 'rails_helper'


RSpec.describe User, type: :model do
  let!(:user) { create(:user) }
  before { user.email = 'foo@bar.com' }
  

  describe ' validation ' do

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should validate_presence_of :password}
  it { should validate_length_of :password }
  it { should validate_presence_of :password_confirmation }

  end
  
  describe '#email' do

    it 'save correct email' do
      expect(user).to be_valid
    end

    it 'validate email format' do
      user.email = "foobar"
      expect(user).to be_invalid
    end
    
  end

  describe '#role' do
    
    it 'give default standart role' do
      expect(user.role).to eq("standart")
    end

    it 'change role to admin' do
      user.admin!
      expect(user.role).to eq("admin")
    end

  end

  describe '#password' do

    it 'validate password_confirmation ' do
      user.password_confirmation = ""
      expect(user).to be_invalid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

  end

end
