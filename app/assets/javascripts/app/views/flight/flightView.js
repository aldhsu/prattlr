var app = app || {};

// single row of flight details
app.FlightView = Backbone.View.extend({
  tagName: 'div',
  initialize: function() {
    _.bindAll(this, 'render');
    this.model.bind('change', this.render);
  },
  events: {
    'click button': 'view'
  },
  render: function() {
    var flightHTML = Handlebars.compile( app.templates.flightView );
    var modelJSON = this.model.toJSON();
    // var booked =
    modelJSON['seats'] = 7;
    var copy = flightHTML( modelJSON );
    this.$el.append( copy );
    return this.el;
  },
  view: function(){
     app.router.navigate('flights/' + this.model.get('id'), true );
  }

});