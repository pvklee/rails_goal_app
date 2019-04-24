class FixComment < ActiveRecord::Migration[5.2]
  def change
    drop_table :user_comments
    drop_table :goal_comments

    create_table :user_comments do |t|
      t.integer :commenter_id, null: false
      t.integer :user_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end
    add_index :user_comments, :commenter_id
    add_index :user_comments, :user_id

    create_table :goal_comments do |t|
      t.integer :commenter_id, null: false
      t.integer :goal_id, null: false
      t.text :comment_text, null: false

      t.timestamps
    end
    add_index :goal_comments, :commenter_id
    add_index :goal_comments, :goal_id

  end
end
