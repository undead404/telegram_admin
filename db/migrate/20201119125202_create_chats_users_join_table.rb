class CreateChatsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :bots, :users do |t|
      t.index :bot_id
      t.index :user_id
    end
  end
end
