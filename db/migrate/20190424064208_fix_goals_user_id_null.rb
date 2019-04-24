class FixGoalsUserIdNull < ActiveRecord::Migration[5.2]
  def change
      remove_index :goals, :user_id
      add_index :goals, :user_id
  end
end
