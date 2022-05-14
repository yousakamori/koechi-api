class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.boolean :liked, null: false, default: false
      t.references :user, null: false, foreign_key: true
      t.references :likable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
