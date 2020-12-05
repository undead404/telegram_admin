require 'date'
require 'json'

module Admin
  class MessagesController < Admin::ApplicationController
    protect_from_forgery with: :exception
    # before_action :authenticate_user!
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #

    def create
      message_params = params[:message]
      message_params[:text] = params[:text]
      message = Message.new(
        author_id: current_user.id,
        chat: Chat.find(message_params[:chat_id]),
        image: message_params[:image],
        parse_mode: message_params[:parse_mode],
        text: (message_params[:text].join "\r\n\r\n")
      )
      puts JSON.pretty_generate message.as_json
      message.save!
      redirect_to action: 'index', notice: 'A message has been created'
      # Message.create!(
      #   author_id: current_user.id,
      #   chat: Chat.find(message_params[:chat_id]),
      #   image: message_params[:image],
      #   parse_mode: message_params[:parse_mode],
      #   text: (message_params[:text].join "\r\n\r\n")
      # )
    end

    def update
      message_params = params[:message]
      message_params[:text] = params[:text]
      Message.find(params[:id]).update!(
        chat: Chat.find(message_params[:chat_id]),
        image: message_params[:image],
        parse_mode: message_params[:parse_mode],
        text: (message_params[:text].join "\r\n\r\n")
      )
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end
    # Limit the scope of the given resource
    def scoped_resource
      if current_user.admin?
        super
      else
        current_user.messages
      end
    end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def publish
      message = Message.find(params[:message_id])
      bot = bot_for_chat(message.chat)
      data = bot.publish_message(message)
      message.update!(sent_at: Date.strptime(data['date'].to_s, '%s'))
      redirect_to admin_message_path(message), notice: "Message \"#{message}\" has been published to #{message.chat}."
    end

    def show_action?(action, resource)
      !(action == :edit && resource.published?)
    end

    private

    def bot_for_chat(chat)
      current_user.bots.find do |bot_item|
        bot_item.chats.any? do |chat_item|
          chat_item.id == chat.id
        end
      end
    end
  end
end
