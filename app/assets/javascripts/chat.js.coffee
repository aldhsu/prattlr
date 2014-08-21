# Helpers
app.changeDate = (message) ->
  message.set('created_at', moment(message.get('created_at')).format('HH:mm:ss DD/MM/YY'))

# courtesy of PogoApp https://github.com/themgt/ws42-chat.git
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
    @bindEvents()
    @loadMore()

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    @dispatcher.bind 'user_list', @updateUserList
    $('input#user_name').on 'keyup', @updateUserInfo
    $('#send').on 'click', @sendMessage
    $('#message').keypress (e) -> $('#send').click() if e.keyCode == 13 #run click if keypress = enter

  newMessage: (message) =>
    @messageQueue.push message
    @shiftMessageQueue() if @messageQueue.length > 15
    @appendMessage message

  sendMessage: (event) =>
    event.preventDefault()
    message = $('#message').val()
    if app.context.reply
      console.log(app.context.reply)
      @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message, parent_id: app.context.reply}
    else
      @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}
    $('#message').val('')
    console.log('sent')

  updateUserList: (userList) =>
    $('#user-list').html @userListTemplate(userList)

  updateUserInfo: (event) =>
    @user.user_name = $('input#user_name').val()
    $('#username').html @user.user_name
    @dispatcher.trigger 'change_username', @user.serialize()

  appendMessage: (message) ->
    model = new app.Message()
    model.attributes = message
    app.changeDate(model)
    view = new app.MessageView({model: model})
    if model.get('parent_id')
      $div = $($("[data-message-id=#{model.get('parent_id')}]").parent('div')[0])
      view.css('margin-left', (parseInt($div.css('margin-left')) + 5))
      $div.after(view.render())
    else
      $('#chat').append(view.render())
    $('#chat').scrollTop($('#chat')[0].scrollHeight)

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
    $('#username-display').html 'Signed in as ' + @user.user_name
    @dispatcher.trigger 'new_user', @user.serialize()

  loadMore: =>
    html =
      """
        <p class="load-more">
          <a href='#' id='load-all'>Load All</a>
          <a href='#' id='load-older'>Load Older</a>
        </p>
      """
    $('#chat').prepend(html)
    $('#chat').scrollTop(5)
