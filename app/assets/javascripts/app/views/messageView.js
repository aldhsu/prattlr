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
    this.$el.css('margin-left', 5+'px');
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
    event.stopPropagation();
    if (this.model.get('id')) {
      app.replyview && app.replyview.cancel(); //remove view if it exists
      app.context.reply = this.model.get('id');
      app.replyview = new app.ReplyView({model: this.model});
      $('#user-text-input').prepend(app.replyview.render());
      $('#message').focus();
    }
  }

})