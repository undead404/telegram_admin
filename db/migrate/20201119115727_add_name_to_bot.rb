# frozen_string_literal: true

# Add name for bots to distinguish them
class AddNameToBot < ActiveRecord::Migration[6.0]
  def change
    add_column :bots, :name, :string, unique: true, null: false, default: 'NeprostirBot'
  end
end
