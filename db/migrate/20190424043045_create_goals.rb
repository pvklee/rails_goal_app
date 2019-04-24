class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :goal_title, null: false
      t.text :goal_description
      t.boolean :is_private, null: false, default: true
      t.boolean :is_completed, null: false, default: false

      t.timestamps
    end
    add_index :goals, :user_id, unique: true
  end
end
