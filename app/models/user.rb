class User < ApplicationRecord
    attr_reader :password

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    
    after_initialize :ensure_session_token

    has_many :goals, class_name: 'Goal', foreign_key: :user_id
    has_many :authored_user_comments, class_name: 'UserComment', foreign_key: :commenter_id
    has_many :received_user_comments, class_name: 'UserComment', foreign_key: :user_id
    has_many :authored_goal_comments, class_name: 'GoalComment', foreign_key: :commenter_id

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil if user.nil?
        user.is_password?(password) ? user : nil
    end

    def self.generate_session_token!
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token!
        self.save!
        self.session_token
    end

    private
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token!
    end
end
