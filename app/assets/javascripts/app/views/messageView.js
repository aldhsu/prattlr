var app = app || {};

app.MessageView = Backbone.View.extend({
  tagName: 'div',
  className: 'thread',
  events: {
    'click .label': 'toggleFoldIn',
    'click .msg': 'reply'
  },
  render: function() {
    var temp = Handlebars.compile(app.templates.messageView);
    var html = temp(this.model.toJSON());
    this.$el.html(html);
    this.$el.css('margin-left', 8+'px');
    if (this.model.get('user') .username == app.context.username)
      this.$el.find('.label').css('background-color', 'green')
    else if (this.model.get('user'))
      this.$el.find('.label').css('background-color', 'black')
    return this.$el;
  },

  toggleFoldIn: function(event) {
    event.stopPropagation();
    this.$el.children('.thread').slideToggle();
    this.$el.find('.label').toggleClass('folded')
  },

  reply: function(event) {
    event.stopPropagation(); //allow click through
    if (this.model.get('id')) {
      app.replyView && app.replyView.cancel(); //remove view if it exists
      app.context.reply = this.model.get('id'); //which parent
      app.replyView = new app.ReplyView({model: this.model});
      this.$el.find('.msg').first().after(app.replyView.render());
      $('.reply-input').first().focus();
    }
  }
})