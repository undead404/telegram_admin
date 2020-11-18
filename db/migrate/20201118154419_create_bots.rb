class CreateBots < ActiveRecord::Migration[6.0]
  def change
    create_table :bots do |t|
      t.string :encrypted_token
      t.string :encrypted_token_iv

      t.timestamps
    end
  end
end
