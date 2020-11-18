# frozen_string_literal: true

# Telegram bot with its auth token
class Bot < ApplicationRecord
  attr_encrypted :token, key: ENV['ENCRYPTION_SECRET'], unless: Rails.env.development?
end
