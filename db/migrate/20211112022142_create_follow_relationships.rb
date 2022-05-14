class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.references :follower, foreign_key: { to_table: :users }
      t.references :following, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follow_relationships, %i[follower_id following_id], unique: true
  end
end
