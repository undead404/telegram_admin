class AddBotReferenceToChat < ActiveRecord::Migration[6.0]
  def change
    create_join_table :bots, :chats do |t|
      t.index :bot_id
      t.index :chat_id
    end
  end
end
