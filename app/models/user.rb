class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: { message: "password can't be blank" }

  after_initialize :ensure_session_token

  has_one :profile, inverse_of: :user
  has_many :accounts
  has_many :transactions, through: :accounts, source: :transactions
  has_many :budgets
  has_many :goals
  #follow model for people following you
  has_many(:follower_joins, class_name: 'Follow', foreign_key: :follower_id, primary_key: :id)
  #follow model for people you are following
  has_many(:followed_joins, class_name: 'Follow', foreign_key: :followed_id, primary_key: :id)

  has_many(:followers, through: :followed_joins, source: :follower)
  has_many(:followed_users, through: :follower_joins, source: :followed)

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

  def publish_shares
    self.budgets.where(private: false, is_active: true).each do |budget|
      budget.create_public_share({ user_id: self.id, is_new: false })
    end

    self.goals.where(private: false, is_active: true).each do |goal|
      goal.create_public_share({ user_id: self.id, is_new: false })
    end
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