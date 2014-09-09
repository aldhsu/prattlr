# Helpers
app.changeDate = (message) ->
  message.set('created_at', moment(message.get('created_at')).format('HH:mm:ss DD/MM/YY'))

app.getIndent = (view, message) ->
  $div = $("[data-message-id=#{message.get('parent_id')}]").parent('div').first()
  $div.append(view.render(parseInt($div.css('margin-left'))))

# modified from of PogoApp https://github.com/themgt/ws42-chat.git
window.Chat = {}

class Chat.User
  constructor: (@user_name) ->
  serialize: => { user_name: @user_name }

class Chat.Controller
  userListTemplate: (userList) ->
    userHtml = ""
    for user in userList
      userHtml = userHtml + "<li>#{user.user_name}</li>"
    $(userHtml)
  # constructor is automatically run when on new instantiation(uri passed from chat window, true on useWS)
  constructor: (url,useWebSockets) ->
    @messageQueue = []
    @dispatcher = new WebSocketRails(url,useWebSockets)
    @channel = @dispatcher.subscribe('javascript')
    @bindEvents()
    @loadMore()

  bindEvents: =>
    # messages to server need to be sent by global channel to be routed
    # server can send back on channel
    # CLIENT SIDE DATA BINDING
    @channel.bind 'new_message', @newMessage
    @channel.bind 'user_list', @updateUserList
    @channel.bind 'user_list', @updateUserList
    # CLIENT SIDE TRIGGER
    $('input#user_name').on 'keyup', @updateUserInfo
    $('#send').on 'click', (e) =>
      e.preventDefault()
      @sendMessage($('#message-input').val())
      $('#message-input').val('')
      $('#chat').scrollTop($('#chat')[0].scrollHeight)
    $('#message-input').keypress (e) ->
      $('#send').click() if e.keyCode == 13 #run click if keypress = Enter

  newMessage: (message) =>
    console.log(message)
    @messageQueue.push message
    @shiftMessageQueue() if @messageQueue.length > 15
    @appendMessage message

  sendMessage: (message) =>
    # try to send message catch if no username
    try
      # attach parent if available (could be sanitised on server)
      if app.context.reply
        data = {
          user_name: @user.user_name,
          msg_body: message,
          parent_id: app.context.reply,
          room_id: app.context.channel
        }
        @dispatcher.trigger 'new_message', data
      else
        @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message, room_id: app.context.channel}
    catch
      alert("Sign in to post messages")

  updateUserList: (userList) =>
    $('#user-list').html @userListTemplate(userList)

  updateUserInfo: (event) =>
    @user.user_name = $('input#user_name').val()
    $('#username').html @user.user_name
    @channel.trigger 'change_username', @user.serialize()

  appendMessage: (message) ->
    console.log('appending')
    model = new app.Message()
    model.attributes = message
    app.changeDate(model)
    view = new app.MessageView({model: model})
    if model.get('parent_id')
      app.getIndent(view, model)
    else
      $('#chat').append(view.render())


  shiftMessageQueue: =>
    @messageQueue.shift()
    $('#chat div.messages:first').slideDown 100, ->
      $(this).remove()

  createGuestUser: =>
    rand_num = Math.floor(Math.random()*1000)
    @user = new Chat.User("Guest_" + rand_num)
    $('#username-display').html @user.user_name
    @channel.trigger 'new_user', @user.serialize()

  loginUser: (name) =>
    @user = new Chat.User(name)
    $('#username-display').html 'Signed in as ' + @user.user_name
    @channel.trigger 'new_user', @user.serialize()

  logoutUser: (name) =>
    @channel.trigger 'delete_user', @user.serialize()

  loadMore: =>
    html =
      """
        <p class="load-more">
          <a href='#' id='load-all'>Load All</a>
        </p>
      """
    $('#chat').prepend(html)
    $('#chat').scrollTop(5)
