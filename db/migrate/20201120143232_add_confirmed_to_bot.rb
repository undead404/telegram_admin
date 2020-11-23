# frozen_string_literal: true

# Add confirmed field showing that the bot is working with Telegram API
class AddConfirmedToBot < ActiveRecord::Migration[6.0]
  def change
    add_column :bots, :confirmed, :boolean, null: false, default: false
  end
end
