var app = app || {};
// singular where can book
app.FlightShowView = Backbone.View.extend({
  el: '#main',
  initialize: function() {
    this.render();
  },
  render: function() {
    var html = Handlebars.compile( app.templates.airplaneShowView );
    var copy = html( this.model.toJSON() );
    this.$el.html( copy );
    var plane_id = this.model.get('airplane_id');
    var plane = app.airplanes.get(plane_id)
    var seating = new app.ReserveSeatingView({model: plane, flight: this.model});
  }

});