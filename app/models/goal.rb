class Goal < ApplicationRecord
    validates :user_id, presence: true, uniqueness: true
    validates :goal_title, :goal_description, presence: true
    validates :is_private, :is_completed, inclusion: {in: [true, false]}

    belongs_to(
        :users,
        class_name: 'User',
        foreign_key: :user_id)
    
    
end
