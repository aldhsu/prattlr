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
  # Listen to sign in and handle
  app.context = {}
  $('#sign-in-ajax').on 'ajax:success', (xhr, data) ->
    try
      $(this).slideToggle()
      signIn(data)
    catch
      console.log('no user')

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
            $target.find("[data-message-id=#{message.get('parent_id')}]").parent('div').after(view.render())
          else
            $target.append(view.render())
      )
    $('#chat').prepend($target)
    $(this).parent().remove()
# Helpers
signIn = (data) ->
  username = data.username
  window.chatController.loginUser(username)
  $('#user-settings').toggleClass 'hidden'

logOut = ->
  $.ajax(
    url: '/'
      )
