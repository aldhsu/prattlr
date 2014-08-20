# Listener setup
jQuery ->
  window.chatController = new Chat.Controller($('#chat').data('uri'), true);
  # Listen to sign in and handle
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
    console.log($(this).closest('.message'))

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
