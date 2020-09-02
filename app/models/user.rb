class User < ApplicationRecord
    enum role: [:standart, :admin]

    before_save { self.email = email.downcase! }

    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        uniqueness: true,
        format: { with: EMAIL_FORMAT }
    
    validates :password,
        presence: true,
        length: { minimum: 5 }

    validates :password_confirmation, presence: true

    after_initialize do
        if self.new_record?
            self.role ||= :standart
        end
    end

    has_many :posts, dependent: :destroy
    has_many :comments, through: :comments

    has_secure_password


end