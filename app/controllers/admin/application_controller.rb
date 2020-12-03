# frozen_string_literal: true

# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  # Main admin controller
  class ApplicationController < Administrate::ApplicationController
    # before_action :authenticate_admin
    before_action :authenticate_user!
    # before_action :authorize_resource

    # def authenticate_admin
    #   # TODO: Add authentication logic here.
    #   authenticate_user!
    #   authorize_resource(resource)
    # end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    # Redirect if the user is not permitted to access this resource
    def authorize_resource(resource)
      redirect_to admin_root_path unless show_action?(params[:action], resource)
    end

    # Hide links to actions if the user is not allowed to do them
    def show_action?(_action, resource)
      return true if current_user.admin?

      resource.to_s != 'User'
    end
  end
end
