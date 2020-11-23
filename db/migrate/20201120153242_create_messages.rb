class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text, null: false
      t.string :parse_mode
      t.datetime :sent_at

      t.timestamps
    end
    add_reference :messages, :chat, foreign_key: true, null: false
  end
end
