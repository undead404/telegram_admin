# == Schema Information
#
# Table name: bots
#
#  id                 :bigint           not null, primary key
#  encrypted_token    :string
#  encrypted_token_iv :string
#  name               :string           default("f"), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  owner_id           :bigint
#
# Indexes
#
#  index_bots_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require 'test_helper'

class BotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
