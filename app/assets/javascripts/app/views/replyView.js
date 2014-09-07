var app = app || {};

app.ReplyView = Backbone.View.extend({
  tagName: 'div',
  className: 'reply-message',
  events: {
    'click button': 'sendMessage',
    'keypress': 'sendMessage'
  },
  render: function() {
    var temp = Handlebars.compile(app.templates.replyView);
    var html = temp(this.model.toJSON());
    this.$el.html(html);
    return this.$el;
  },
  cancel: function(event) {
    app.context.reply = null;
    this.$el.remove();
  },
  sendMessage: function(event) {
    if (event.keyCode === 13) {
      var message = this.$el.find('.reply-input').val();
      window.chatController.sendMessage(message);
      this.cancel();
    }
  }
})