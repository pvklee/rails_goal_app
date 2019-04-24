class UserComment < ApplicationRecord
    validates :commenter_id, :user_id, :comment_text, presence: true

    belongs_to :user, class_name: 'User', foreign_key: :user_id
    belongs_to :commenter, class_name: 'User', foreign_key: :commenter_id
    
end
