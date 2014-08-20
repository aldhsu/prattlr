var app = app || {};

app.AirplaneNewView = Backbone.View.extend({
  tagName: 'div',
  events: {
    'click button': 'addNewAirplane',
    'submit': 'addNewAirplane',
  },
  initialize: function() {
    // this.render()
  },
  render: function() {
    console.log('creating new view')
    this.$el.html( app.templates.airplaneNewView );
    return this.el;
  },
  addNewAirplane: function(event){
    console.log(event)
    if (event.type == 'submit') {
      event.preventDefault();
    }
    var newPlane = new app.Airplane( {name: $('#airplane-name').val(), rows: $('#airplane-rows').val(), cols: $('#airplane-cols').val()} )
    newPlane.save();
    app.airplanes.add(newPlane);
  },
});