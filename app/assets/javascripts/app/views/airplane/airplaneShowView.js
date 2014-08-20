var app = app || {};

app.AirplaneShowView = Backbone.View.extend({
  el: '#main',
  initialize: function() {
    this.render();
  },
  render: function() {
    var html = Handlebars.compile( app.templates.airplaneShowView );
    var copy = html( this.model.toJSON() );
    this.$el.html( copy );
    console.log(this)
    var seating = new app.SeatingView({model: this.model});
  }

});