# Setup Backbone
app.messages = new app.Messages

jQuery ->
  # Template Get
  app.templates = {
    messageView: $('#message-view').html()
  }
  # Listener setup
  window.chatController = new Chat.Controller($('#chat').data('uri'), true);
  # Listen to sign in and handle
  window.chatController.context = {}
  $('#sign-in-ajax').on 'ajax:success', (xhr, data) ->
    try
      $(this).slideToggle()
      signIn(data)
    catch
      console.log('no user')

  # Fold out on label click
  $('#chat').on 'click', 'label', ->
    console.log($(this).closest('.message'))

  # Put line being answered into input-box
  $('#chat').on 'click', 'p', ->
    $(this).text()
    $(this).closest('.message')

  # Load all older ones on click
  $('#load-all').on 'click', ->
    app.messages.fetch().done ->
      _.each(app.messages.sortBy((message)->
        return message.created_at
        ).reverse(), (message) ->
          message.set('created_at', moment(message.get('created_at')).format('DD MMM HH:mm'))
          view = new app.MessageView({model: message})
          $('#chat').prepend(view.render())
      )
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

foldOut = ->

foldIn = ->
