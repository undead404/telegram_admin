# frozen_string_literal: true

# Base class for all controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  def after_sign_in_path_for(_resource)
    admin_root_path
  end
end
