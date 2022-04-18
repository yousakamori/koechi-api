class CreateTalks < ActiveRecord::Migration[6.1]
  def change
    create_table :talks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :slug, null: false
      t.boolean :archived, null: false, default: false
      t.boolean :closed, null: false, default: false
      t.datetime :closed_at, precision: 6,default: nil
      t.datetime :last_comment_created_at, precision: 6,default: nil
      t.integer :comments_count, null: false, default: 0
      t.integer :liked_count, null: false, default: 0

      t.timestamps
    end
    add_index :talks, :slug, unique: true
  end
end
