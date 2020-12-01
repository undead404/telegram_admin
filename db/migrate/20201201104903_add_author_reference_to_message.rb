class AddAuthorReferenceToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :author, foreign_key: { to_table: :users }
  end
end
