class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: nil
      t.text :body_text, default: nil
      t.text :body_json, default: nil
      t.string :slug, null: false
      t.datetime :body_updated_at, precision: 6, default: nil
      t.datetime :posted_at, precision: 6, default: nil
      t.datetime :last_comment_created_at, precision: 6, default: nil
      t.integer :comments_count, null: false, default: 0
      t.integer :liked_count, null: false, default: 0

      t.timestamps
    end
    add_index :notes, :slug, unique: true
  end
end
