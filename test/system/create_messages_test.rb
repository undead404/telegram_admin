require 'application_system_test_case'

class CreateMessagesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  test 'create a message' do
    sign_in users :helping_hand
    visit new_admin_message_url

    page.select '1', from: 'message[chat_id]'
    page.select 'HTML', from: 'message[parse_mode]'
    fill_in 'text-1', with: 'Test message'
    click_on 'Create Message'
    assert Message.last.text == 'Test message'
    # assert_selector 'h1', text: 'CreateMessage'
  end
end
