# Helpers
signIn = (data) ->
  username = data.username
  $("#username-display").attr('data-user-id', data.id)
  $('#sign-in-ajax').slideToggle()
  $('#sign-up-button').toggle()
  window.chatController.loginUser(username)
  $('#user-settings').toggleClass 'hidden'

logOut = ->
  username = $("#username-display").attr('data-user-name')
  userid = $("#username-display").attr('data-user-id')
  window.chatController.logoutUser(username)
  $.ajax({
    url: "/sessions/#{userid}",
    method: 'delete',
    success: (xhr, data) ->
      $('#sign-up-button').toggle()
      $('#sign-in-ajax').toggle()
      $('#user-settings').toggleClass 'hidden'
      window.location.href = '/'
  })

# Setup Backbone
app.messages = new app.Messages

jQuery ->
  # Template Get
  app.templates = {
    messageView: $('#message-view').html()
    replyView: $('#reply-view').html()
  }
  # Listener setup
  window.chatController = new Chat.Controller($('#chat').data('uri'), true);
  app.context = {}

  # Check for already signed in
  if (username = $("#username-display").attr('data-user-name')) != ""
    signIn({username: username})

  # Check Url
  console.log(window.location.pathname)
  # Listen to sign in and handle
  $('#sign-in-ajax').on 'ajax:success', (xhr, data) ->
    try
      signIn(data)
    catch
      $(this).velocity('callout.shake')

  # Load all older ones on click
  $('#load-all').on 'click', ->
    $target = $('<div>')
    app.messages.fetch().done ->
      _.each(app.messages.sortBy((message)->
        return message.get('created_at')
        ), (message) ->
          app.changeDate(message)
          view = new app.MessageView({model: message})
          if message.get('parent_id')
            app.getIndent(view, message)
          else
            $target.append(view.render())
      )
    $('#chat').prepend($target)
    $(this).parent().remove()

  # Sign Up listen
  $('#sign-up-button').click ->
    window.location.href = '/users/new'
  #Listen to logout
  $('#logout').on 'click', ->
    logOut()

