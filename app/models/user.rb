class User < ApplicationRecord
    enum role: [:standart, :admin]

    has_secure_password

    # attr_accessor :email, :password, :password_confirmation, :name

    before_save { self.email = email.downcase! }

    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email,
        presence: true,
        uniqueness: true,
        format: { with: EMAIL_FORMAT }

    validates :password_digest, presence: true, length: { minimum: 5 }
    
    after_initialize do
        if self.new_record?
            self.role ||= :standart
        end
    end

    has_many :posts, dependent: :destroy

end