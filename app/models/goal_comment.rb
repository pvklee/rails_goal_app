class GoalComment < ApplicationRecord
    validates :commenter_id, :goal_id, :comment_text, presence: true

    belongs_to :goal, class_name: 'Goal', foreign_key: :goal_id
    belongs_to :commenter, class_name: 'User', foreign_key: :commenter_id
    
end
