class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validate :title, presence: true, lenght: { minimum: 5 }
  validate :content, presence: true, lenght: { minimum: 10 }
end
