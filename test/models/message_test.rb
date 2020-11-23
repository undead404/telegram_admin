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
#  chat_id            :bigint           not null
#  message_id         :integer
#
# Indexes
#
#  index_messages_on_chat_id  (chat_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_id => chats.id)
#
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
