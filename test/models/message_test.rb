# == Schema Information
#
# Table name: messages
#
#  id                 :bigint           not null, primary key
#  image_content_type :string
#  image_file_name    :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  parse_mode         :string           default("Plain text")
#  sent_at            :datetime
#  text               :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  author_id          :bigint
#  chat_id            :bigint           not null
#  message_id         :integer
#
# Indexes
#
#  index_messages_on_author_id  (author_id)
#  index_messages_on_chat_id    (chat_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (chat_id => chats.id)
#
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test 'can not be created for chat not owned' do
  #   assert_not Message.create!(
  #     author: users(:helping_hand),
  #     chat: chats(:cooking_chat),
  #     text: 'hello to cookers'
  #   )
  # end
  test 'can be created' do
    assert Message.create!(
      author: users(:helping_hand),
      chat: chats(:walking_channel),
      text: 'hello to walkers'
    )
  end
end
