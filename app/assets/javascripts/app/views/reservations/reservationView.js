var app = app || {};

app.ReservationView = Backbone.View.extend({
  tagName: 'div',
  initialize: function() {
    _.bindAll(this, 'render');
    this.model.bind('change', this.render);
  },
  render: function() {
    var reservationHTML = Handlebars.compile( app.templates.reservationView );
    var copy = reservationHTML( this.model.toJSON() );
    this.$el.append( copy );
    return this.el;
  }
});