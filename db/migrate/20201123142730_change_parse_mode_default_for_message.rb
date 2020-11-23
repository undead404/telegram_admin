class ChangeParseModeDefaultForMessage < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:messages, :parse_mode, from: nil, to: 'Plain text')
  end
end
