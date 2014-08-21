var app = app || {};

app.MessageView = Backbone.View.extend({
  tagName: 'div',
  events: {
    'click .label': 'toggleFoldIn',
    'click .msg': 'reply'
  },
  render: function(left) {
    left = left || 0;
    var temp = Handlebars.compile(app.templates.messageView);
    var html = temp(this.model.toJSON());
    this.$el.html(html);
    this.$el.css('margin-left', (left + 5)+'px');
    return this.$el;
  },
  toggleFoldIn: function(event) {
    this.$el.next();
  },

  reply: function(event) {
    if (this.model.get('id')) {
      app.replyview && app.replyview.cancel() //remove view if it exists
      app.context.reply = this.model.get('id')
      app.replyview = new app.ReplyView({model: this.model})
      $('#user-text-input').prepend(app.replyview.render())
    }
  }

})