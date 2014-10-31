class User < ActiveRecord::Base
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  attr_reader :password
  
  after_initialize :ensure_session
  
  def self.new_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user && user.valid_password?(password)
    user
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def valid_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
  
  def reset_token!
    self.session_token = self.class.new_token
    self.save!
    self.session_token
  end
  
  private
  def ensure_session
    self.session_token ||= self.class.new_token
  end
end
