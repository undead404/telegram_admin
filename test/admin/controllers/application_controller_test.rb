# frozen_string_literal: true

require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'should redirect to login if unauthorized' do
    get admin_root_url
    assert_redirected_to user_session_url
  end
  test 'should not show Users link if not admin' do
    sign_in users :helping_hand
    get admin_root_url
    assert_select 'a', text: 'Users', count: 0
  end
  test 'should show Users link if admin' do
    sign_in users :author
    get admin_root_url
    assert_select 'a', text: 'Users'
  end
end
