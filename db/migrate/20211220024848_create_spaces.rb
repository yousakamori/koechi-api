class CreateSpaces < ActiveRecord::Migration[6.1]
  def change
    create_table :spaces do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :emoji, null: false
      t.string :slug, null: false
      t.boolean :archived, null: false, default: false
      t.boolean :favorite, null: false, default: false
      t.datetime :archived_at, precision: 6, default: nil
      t.integer :notes_count, null: false, default: 0

      t.timestamps
    end

    add_index :spaces, :slug, unique: true
  end
end
