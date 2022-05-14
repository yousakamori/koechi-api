class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.references :space, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :role, null: false, default: 0

      t.timestamps
    end

    add_index :memberships, %i[space_id user_id], unique: true
  end
end
