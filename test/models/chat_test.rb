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
require 'test_helper'

class ChatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
