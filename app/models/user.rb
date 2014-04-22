class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: { message: "password can't be blank" }

  after_initialize :ensure_session_token

  has_one :profile, inverse_of: :user
  has_many :accounts

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return (user.try(:is_password?, password) ? user : nil)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end