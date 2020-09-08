class Message
    def self.not_found(record = 'record')
        "Sorry, #{record} not found."
    end

    def self.invalid_credential
        'Invalid credentials'
    end

    def self.invalid_token
        'Invalid token'
    end

    def self.missing_token
        'Missing token'
    end

    def self.unauthorized
        'Unauthorized request'
    end

    def self.accout_created
        'Account created successfully'
    end

    def self.accout_not_created
        'Account could not be created'
    end

    def self.expired_token
        'Sorry, your token has expired. Please login to continue'
    end
end