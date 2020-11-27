# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'index should redirect to login if unauthorized' do
    get admin_root_url
    assert_redirected_to user_session_url
  end
  test 'index should show messages for admin user' do
    sign_in users :author
    get admin_root_url
    assert_response :success
    assert_select 'a', text: 'This is my post'
    assert_select "[href='#{new_admin_message_path}']", text: 'New message'
  end
end
