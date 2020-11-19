# Removing default value
class ChangeBotName < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:bots, :name, from: nil, to: false)
  end
end
