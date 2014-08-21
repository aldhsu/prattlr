# courtesy of PogoApp https://github.com/themgt/ws42-chat.git
class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  # before_action :authenticate_user

  def initialize_session
    puts "Session Initialized\n"
  end

  def system_msg(ev, msg)
    broadcast_message ev, {
      user: {username: 'system'},
      created_at: Time.now.to_s(:short),
      content: msg
    }
  end

  # def user_msg(ev, msg, id)
  def user_msg(ar_message)
    # broadcast_message ev, {
    #   msg_id: id,
    #   username:  connection_store[:user][:user_name],
    #   created_at:   Time.now.to_s(:short),
    #   content:   ERB::Util.html_escape(msg)
    #   }
    broadcast_message :new_message, ar_message.as_json(:include => {:user => {:only => :username}})
  end

  def client_connected
    system_msg :new_message, "client #{client_id} connected"
  end

  def new_message
    user = User.find_by(username: data[:user_name])
    if user
      message = Message.create(content: data[:msg_body], user_id: user.id, parent_id: data[:parent_id])
      # user_msg :new_message, data[:msg_body].dup, message.id
      user_msg message
    end
  end

  def new_user
    connection_store[:user] = { user_name: sanitize(message[:user_name]) }
    broadcast_user_list
  end

  def change_username
    connection_store[:user][:user_name] = sanitize(message[:user_name])
    broadcast_user_list
  end

  def delete_user
    puts 'deleting user'
    connection_store[:user] = nil
    system_msg "client #{client_id} disconnected"
    broadcast_user_list
  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

end

