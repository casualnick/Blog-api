require 'rails_helper'

RSpec.describe Post, type: :model do
  
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }
  it { should validate_length_of :title }
  it { should validate_length_of :content }
  it { should belong_to :user }
end
