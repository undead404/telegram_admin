# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  name       :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chat < ApplicationRecord
  has_and_belongs_to_many :bots, join_table: 'bots_chats'
  has_and_belongs_to_many :users, join_table: 'chats_users'
  has_many :messages
  def chat_id
    "@#{username}"
  end

  def inspect
    name || username
  end
end
