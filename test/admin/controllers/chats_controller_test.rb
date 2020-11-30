# frozen_string_literal: true

require 'test_helper'

class ChatsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'index should redirect to login if unauthorized' do
    get admin_chats_url
    assert_redirected_to user_session_url
  end
  test 'index should show' do
    sign_in users :helping_hand
    get admin_chats_url
    assert_response :success
    # assert_select 'a', text: 'This is my post'
    # assert_select "[href='#{new_admin_message_path}']", text: 'New message'
  end
end
