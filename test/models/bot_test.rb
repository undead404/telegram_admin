# frozen_string_literal: true

# == Schema Information
#
# Table name: bots
#
#  id                 :bigint           not null, primary key
#  confirmed          :boolean          default(FALSE), not null
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
  setup
  test 'is valid with valid attributes' do
    assert Bot.create(name: 'TestBot', owner: users(:author))
  end
  test 'is valid with lowercased ending' do
    assert Bot.create(name: 'test_bot', owner: users(:author))
  end
  test 'Invalid without a name ending with "bot"' do
    bot = Bot.new(name: 'TestPerson', owner: users(:author))
    assert_not bot.valid?
    assert_includes bot.errors[:name], 'should end with "bot" or "Bot"'
    assert_not bot.save
  end
  test 'Invalid without an owner' do
    bot = Bot.new(name: 'TestPerson')
    assert_not bot.valid?
    assert_includes bot.errors[:owner], 'should belong to a user'
    assert_not bot.save
  end
end
