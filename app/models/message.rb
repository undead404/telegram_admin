require 'redcarpet'
require 'redcarpet/render_strip'

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

$markdown_to_plain_text = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)

class Message < ApplicationRecord
  after_save :edit, if: :text_changed?
  belongs_to :chat
  has_attached_file :image,
                    cloudinary_credentials: {
                      api_key: ENV['CLOUDINARY_API_KEY'],
                      api_secret: ENV['CLOUDINARY_API_SECRET'],
                      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
                      enhance_image_tag: true,
                      static_file_support: Rails.env.production?
                    },
                    path: ':id/:style/:filename',
                    storage: :cloudinary,
                    styles: {
                      normal: '600x600>',
                      small: '300x300>',
                      thumbnail: '40x40>'
                    }
  readonly :chat
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_inclusion_of :parse_mode, in: %w[Markdown HTML], allow_null: true, message: '%s is not valid'
  validates_presence_of :chat, message: 'should belong to a chat'
  validate :meaningful?

  # def publish
  #   puts JSON.pretty_generate as_json
  #   data = if image.present?
  #            bot.publish_photo(self)
  #          else
  #            bot.publish_message(self)
  #          end
  #   update!(message_id: data['message_id'], sent_at: data['date'])
  # end

  def inspect
    (if parse_mode == 'Markdown'
       $markdown_to_plain_text.render text
     else
       text
     end).truncate 27
  end

  def published?
    message_id.present?
  end

  private

  def bot
    current_user.bots.find do |bot_item|
      bot_item.chats.include? do |chat_item|
        chat_item.id == chat.id
      end
    end
  end

  def edit
    bot.edit_message_text(self) if message_id
  end

  def meaningful?
    text.present?
  end
end
