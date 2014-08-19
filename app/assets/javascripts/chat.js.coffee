# # courtesy of PogoApp https://github.com/themgt/ws42-chat.git
jQuery ->
  window.chatController = new Chat.Controller($('#chat').data('uri'), true);
  # Listen to sign in
  $('#sign-in-ajax').on 'ajax:success', (xhr, data) ->
    try
      window.chatController.loginUser(data.username)
      console.log(this)
      $(this).slideToggle()
    catch
      console.log('no user')

window.Chat = {}

class Chat.User
  constructor: (@user_name) ->
  serialize: => { user_name: @user_name }

class Chat.Controller
  template: (message) ->
    html =
      """
      <div class="message" >
        <label class="label label-info" message-id ='#{message.msg_id}'>
          [#{message.received}] #{message.user_name}
        </label>&nbsp;
        #{message.msg_body}
      </div>
      """
    $(html)

  userListTemplate: (userList) ->
    userHtml = ""
    for user in userList
      userHtml = userHtml + "<li>#{user.user_name}</li>"
    $(userHtml)

  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url,useWebSockets)
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    @dispatcher.bind 'user_list', @updateUserList
    $('input#user_name').on 'keyup', @updateUserInfo
    $('#send').on 'click', @sendMessage
    $('#message').keypress (e) -> $('#send').click() if e.keyCode == 13

  newMessage: (message) =>
    @messageQueue.push message
    @shiftMessageQueue() if @messageQueue.length > 15
    @appendMessage message

  sendMessage: (event) =>
    event.preventDefault()
    message = $('#message').val()
    @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
    $('#message').val('')
    console.log('sent')

  updateUserList: (userList) =>
    console.log(userList)
    $('#user-list').html @userListTemplate(userList)

  updateUserInfo: (event) =>
    @user.user_name = $('input#user_name').val()
    $('#username').html @user.user_name
    @dispatcher.trigger 'change_username', @user.serialize()

  appendMessage: (message) ->
    messageTemplate = @template(message)
    $('#chat').append messageTemplate
    messageTemplate.slideDown 140

  shiftMessageQueue: =>
    @messageQueue.shift()
    $('#chat div.messages:first').slideDown 100, ->
      $(this).remove()

  createGuestUser: =>
    rand_num = Math.floor(Math.random()*1000)
    @user = new Chat.User("Guest_" + rand_num)
    $('#username-display').html @user.user_name
    # $('input#user_name').val @user.user_name
    @dispatcher.trigger 'new_user', @user.serialize()

  loginUser: (name) =>
    @user = new Chat.User(name)
    $('#username-display').html @user.user_name
    @dispatcher.trigger 'new_user', @user.serialize()

