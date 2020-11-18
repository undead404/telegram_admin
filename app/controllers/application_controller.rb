# frozen_string_literal: true

# Base class for all controllers
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
end
