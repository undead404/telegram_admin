# frozen_string_literal: true

require 'test_helper'

class BotsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'index should redirect to login if unauthorized' do
    get admin_bots_url
    assert_redirected_to user_session_url
  end
  test 'index should show own bots only' do
    sign_in users :helping_hand
    get admin_bots_url
    assert_response :success
    assert_select 'a', text: 'walking_bot'
    assert_select 'a', text: 'cooking_bot', count: 0
    # assert_select "[href='#{new_admin_message_path}']", text: 'New message'
  end
  test 'index should show all bots for admin' do
    sign_in users :author
    get admin_bots_url
    assert_response :success
    assert_select 'a', text: 'walking_bot'
    assert_select 'a', text: 'cooking_bot'
    # assert_select "[href='#{new_admin_message_path}']", text: 'New message'
  end
end
