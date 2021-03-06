class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :follower_id, foreign_key: { to_table: :users }
      t.integer :followed_id, foreign_key: { to_table: :users }

      t.timestamps
    end
    
  end
end
