class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :twitter_username, default: nil
      t.string :unconfirmed_email, default: nil
      t.text :bio
      t.integer :notifications_count, null: false, default: 0
      t.integer :follower_count, null: false, default: 0
      t.integer :following_count, null: false, default: 0
      t.integer :role, null: false, default: 0
      t.integer :failed_attempts, null: false, default: 0
      t.datetime :activated_at, precision: 6, default: nil
      t.datetime :locked_at, precision: 6, default: nil
      t.boolean :email_notify_comments, null: false, default: true
      t.boolean :email_notify_likes, null: false, default: true
      t.boolean :email_notify_followings, null: false, default: true

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
