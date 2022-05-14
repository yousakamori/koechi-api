class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, index: true
      t.text 'body_text', null: false
      t.text 'body_json', null: false
      t.bigint :parent_id, default: nil
      t.datetime 'body_updated_at', precision: 6, default: nil
      t.string 'slug', null: false
      t.integer 'liked_count', default: 0, null: false

      t.timestamps
    end
    add_index :comments, :slug, unique: true
  end
end
