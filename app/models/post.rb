class Post < ApplicationRecord
    has_many :comments
    belongs_to :user

    validates :title, presence: true, length: { minimum: 5 }
    validates :content, presence: true, length: { minimum: 10 }
end
