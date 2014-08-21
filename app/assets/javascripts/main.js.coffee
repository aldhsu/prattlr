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
  # Listen to sign in and handle
  $('#sign-in-ajax').on 'ajax:success', (xhr, data) ->
    try
      signIn(data)
      $(this).slideToggle()
      $('#sign-up-button').toggle()
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

# Helpers
signIn = (data) ->
  username = data.username
  window.chatController.loginUser(username)
  $('#user-settings').toggleClass 'hidden'

logOut = ->
  $.ajax(
    url: '/'
      )
