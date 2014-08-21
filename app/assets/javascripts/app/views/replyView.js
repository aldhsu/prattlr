var app = app || {};

app.ReplyView = Backbone.View.extend({
  tagName: 'div',
  className: 'reply-message',
  events: {
    'click button': 'cancel',
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
  }
})