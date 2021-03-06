class User < ActiveRecord::Base
  attr_reader :password

  has_attached_file :avatar, styles: { thumb: "100x100>" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  after_create :create_profile

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
  has_many :notifications
  has_many :unread_notifications, -> { where(viewed: false) }, class_name: "Notification", foreign_key: :user_id
  has_many :received_fames, class_name: "Fame", foreign_key: :user_receiving_fame_id, primary_key: :id
  has_many :given_fames, class_name: "Fame", foreign_key: :user_giving_fame_id, primary_key: :id
  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id, primary_key: :id
  has_many :received_messages, class_name: "Message", foreign_key: :receiver_id, primary_key: :id

  has_many :unread_messages, -> { where(viewed: false) }, class_name: "Message", foreign_key: :receiver_id
  has_many :authored_comments, class_name: "Comment", foreign_key: :author_id, primary_key: :id

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
    # fail
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def total_fame
    self.received_fames.sum(:value)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def create_profile
    Profile.create(user_id: self.id)
  end

end