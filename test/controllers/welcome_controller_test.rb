# frozen_string_literal: true

require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'should get index for guests' do
    get root_url
    assert_response :success
    assert_select 'a', { count: 1, text: 'Sign in' }
  end
  test 'should get index for users' do
    sign_in users :author
    get root_url
    assert_response :success
    assert_select 'a', { count: 3 }
  end
end
