# frozen_string_literal: true

require 'json'
require 'http'

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

API_URL_TEMPLATE = 'https://api.telegram.org/bot%<bot_token>s/%<api_method_name>s'

# Telegram Bot
class Bot < ApplicationRecord
  attr_encrypted :token, key: [ENV['ENCRYPTION_SECRET']].pack('H*'), unless: Rails.env.development?
  before_save do
    puts JSON.pretty_generate as_json
    self.chats = chats.reject(&:empty?)
  end
  before_validation do
    puts JSON.pretty_generate get_me
    self.confirmed = true
  rescue StandardError => e
    puts e
    self.confirmed = false
  end
  belongs_to :owner, class_name: :User, foreign_key: :owner_id
  has_and_belongs_to_many :chats, join_table: 'bots_chats'
  validates :name, format: {
    message: 'should end with "bot" or "Bot"',
    with: /bot\z/i
  }
  validates_presence_of :owner, message: 'should belong to a user'

  # rubocop:disable Naming/AccessorMethodName

  def get_me
    request_api('getMe')
  end

  def publish_message(message)
    puts 'publish_message'
    message.paragraphs.each_with_index do |paragraph, i|
      if i.zero? && message.image.present?
        publish_photo(message.image, paragraph, message.chat, message.parse_mode)
      else
        params = { chat_id: message.chat.chat_id, text: message.text }
        params[:parse_mode] = message.parse_mode unless message.parse_mode == 'Plain text'
        puts JSON.pretty_generate params
        request_api('sendMessage', :post, { json: params })
      end
    end
  end

  def publish_photo(image, caption, chat, parse_mode = 'Plain text')
    puts 'publish_photo'
    params = { caption: caption, chat_id: chat.chat_id, photo: image.to_s }
    params[:parse_mode] = parse_mode unless parse_mode == 'Plain text'
    puts JSON.pretty_generate params
    request_api('sendPhoto', :post, { form: params })
  end
  # rubocop:enable Naming/AccessorMethodName

  def inspect
    name || username
  end

  private

  def request_api(api_method_name, http_verb = :get, options = {})
    response = HTTP.request(
      http_verb,
      format(API_URL_TEMPLATE, bot_token: token, api_method_name: api_method_name),
      options
    )
    data = JSON.parse response.body.to_s
    puts JSON.pretty_generate data
    raise StandardError, "#{data['error_code']} #{data['description']}" unless data['ok']

    data
  end
end
