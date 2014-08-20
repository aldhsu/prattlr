var app = app || {};

app.ReservationsView = Backbone.View.extend({
  el: '#main',
  initialize: function() {

  },
  render: function(){
    var template = Handlebars.compile( app.templates.reservationsView )
    this.$el.html( template )

    var viewAll = this;
    this.collection.each(function(model){
      var reservationView = new app.ReservationView({model: model});
      viewAll.$el.append( reservationView.render() );
    })

  }
});