class AddAttachmentImageToMessages < ActiveRecord::Migration[6.0]
  def self.up
    change_table :messages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :messages, :image
  end
end
