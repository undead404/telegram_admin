# frozen_string_literal: true

# rubocop:disable Layout/LineLength
# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                            admin_bots GET    /admin/bots(.:format)                                                                    admin/bots#index
#                                       POST   /admin/bots(.:format)                                                                    admin/bots#create
#                         new_admin_bot GET    /admin/bots/new(.:format)                                                                admin/bots#new
#                        edit_admin_bot GET    /admin/bots/:id/edit(.:format)                                                           admin/bots#edit
#                             admin_bot GET    /admin/bots/:id(.:format)                                                                admin/bots#show
#                                       PATCH  /admin/bots/:id(.:format)                                                                admin/bots#update
#                                       PUT    /admin/bots/:id(.:format)                                                                admin/bots#update
#                                       DELETE /admin/bots/:id(.:format)                                                                admin/bots#destroy
#                           admin_chats GET    /admin/chats(.:format)                                                                   admin/chats#index
#                                       POST   /admin/chats(.:format)                                                                   admin/chats#create
#                        new_admin_chat GET    /admin/chats/new(.:format)                                                               admin/chats#new
#                       edit_admin_chat GET    /admin/chats/:id/edit(.:format)                                                          admin/chats#edit
#                            admin_chat GET    /admin/chats/:id(.:format)                                                               admin/chats#show
#                                       PATCH  /admin/chats/:id(.:format)                                                               admin/chats#update
#                                       PUT    /admin/chats/:id(.:format)                                                               admin/chats#update
#                                       DELETE /admin/chats/:id(.:format)                                                               admin/chats#destroy
#                admin_message_publish POST   /admin/messages/:message_id/publish(.:format)                                           admin/messages#publish
#                        admin_messages GET    /admin/messages(.:format)                                                                admin/messages#index
#                                       POST   /admin/messages(.:format)                                                                admin/messages#create
#                     new_admin_message GET    /admin/messages/new(.:format)                                                            admin/messages#new
#                    edit_admin_message GET    /admin/messages/:id/edit(.:format)                                                       admin/messages#edit
#                         admin_message GET    /admin/messages/:id(.:format)                                                            admin/messages#show
#                                       PATCH  /admin/messages/:id(.:format)                                                            admin/messages#update
#                                       PUT    /admin/messages/:id(.:format)                                                            admin/messages#update
#                                       DELETE /admin/messages/:id(.:format)                                                            admin/messages#destroy
#                           admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                                       POST   /admin/users(.:format)                                                                   admin/users#create
#                        new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#                       edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                            admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                                       PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                                       PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                                       DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#                            admin_root GET    /admin(.:format)                                                                         admin/messages#index
#                      new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                                  root GET    /                                                                                        welcome#index
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
# rubocop:enable Layout/LineLength

Rails.application.routes.draw do
  namespace :admin do
    resources :bots
    resources :chats
    resources :messages do
      post 'publish'
    end
    resources :users

    root to: 'messages#index'
  end
  devise_for :users
  # get 'welcome/index'
  root to: 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
