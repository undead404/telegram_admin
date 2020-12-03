# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TelegramAdmin
  # Application's key class
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.react.server_renderer_extensions = %w[jsx js tsx ts]
    Paperclip::Attachment.default_options[:default_url] = '/no_image.png'
  end
end

# Rails.application.configure do
#   config.react.server_renderer_extensions = %w[jsx js tsx ts]
# end
