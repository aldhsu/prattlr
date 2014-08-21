var app = app || {};

app.Messages = Backbone.Collection.extend({

  model: app.Message,
  url: '/messages'
});