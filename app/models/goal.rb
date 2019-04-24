class Goal < ApplicationRecord
    validates :user_id, presence: true
    validates :goal_title, :goal_description, presence: true
    validates :is_private, :is_completed, inclusion: {in: [true, false]}

    belongs_to :user, class_name: 'User', foreign_key: :user_id
    has_many :received_goal_comments, class_name: 'GoalComment', foreign_key: :goal_id
end
