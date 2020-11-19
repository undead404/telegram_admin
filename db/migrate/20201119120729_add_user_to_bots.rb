# frozen_string_literal: true

# Assign bots to owning users
class AddUserToBots < ActiveRecord::Migration[6.0]
  def change
    add_reference :bots, :owner, references: :users
    add_foreign_key :bots, :users, column: :owner_id
  end
end
