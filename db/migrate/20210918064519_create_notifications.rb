class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, foreign_key: { to_table: :users }, null: false
      t.references :notifiable, polymorphic: true, index: true
      t.bigint :sender_id
      t.string :action, null: false
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
