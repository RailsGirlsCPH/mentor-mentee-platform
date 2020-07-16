class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.valid_login
    'Successfully signed in, token issued'
  end

  def self.valid_logout
    'Succesfully logged out'
  end

  def self.user_not_found
    'Unable to find user matching email provided'
  end

  def self.incorrect_password
    'Password incorrect'
  end
  def self.invalid_credentials
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

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.account_deleted
    'Account deleted sucessfully'
  end
end
