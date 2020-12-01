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

$break = "\r\n\r\n"
$markdown_to_plain_text = Redcarpet::Markdown.new(Redcarpet::Render::StripDown)

class Message < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :chat
  has_attached_file :image,
                    cloudinary_credentials: {
                      api_key: ENV['CLOUDINARY_API_KEY'],
                      api_secret: ENV['CLOUDINARY_API_SECRET'],
                      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
                      enhance_image_tag: true,
                      static_file_support: Rails.env.production?
                    },
                    path: "#{Rails.env}/:id/:style/:filename",
                    storage: :cloudinary,
                    styles: {
                      normal: '600x600>',
                      small: '300x300>',
                      thumbnail: '40x40>'
                    }
  readonly :chat
  validate :meaningful?
  validates :author, presence: true
  validates :chat, presence: true
  validates :parse_mode, inclusion: {
    allow_null: true,
    in: ['HTML', 'Markdown', 'Plain text'],
    message: '%<value>s is not valid'
  }
  validates :role, inclusion: { in: %w[admin], allow_null: true }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  def inspect
    (if parse_mode == 'Markdown'
       $markdown_to_plain_text.render text
     else
       text
     end).truncate 27
  end

  def paragraphs
    pgs = []
    max_paragraph_length = image.present? ? 200 : 4096
    inline_pgs = (text.split $break).map(&:strip).reject(&:blank?)
    next_paragraph = ''
    inline_pgs.each do |inline_paragraph|
      next_paragraph_extended = next_paragraph.present? ? "#{next_paragraph}#{$break}#{inline_paragraph}" : inline_paragraph
      if next_paragraph_extended.length > max_paragraph_length
        pgs.push next_paragraph
        next_paragraph = inline_paragraph
        max_paragraph_length = 4096
      else
        next_paragraph = next_paragraph_extended
      end
    end
    pgs.push next_paragraph
    pgs
  end

  def published?
    sent_at.present?
  end

  private

  def bot
    current_user.bots.find do |bot_item|
      bot_item.chats.include? do |chat_item|
        chat_item.id == chat.id
      end
    end
  end

  def meaningful?
    text.present?
  end
end
