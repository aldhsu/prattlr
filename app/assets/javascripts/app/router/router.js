var app = app || {};

app.Router = Backbone.Router.extend({
  routes: {
  '': 'index',
  'flights': 'getFlights',
  'flights/:id': 'getFlight',
  'airplanes': 'getAirplanes',
  'airplanes/:id': 'getAirplane',
  'reservations': 'getReservations',
  'reservation': 'getReservation',
  'users': 'getUsers',
  'users/:id': 'getUser'
  },
  initialize: function() {
    // this.getFlights();
    console.log('routing')
  },
  index: function() {
    console.log('you got index');
  },

  getFlights: function() {
    var view = new app.FlightSearchView({collection: app.flights});
    view.render();
  },

  getFlight: function(id) {
    // var flight = new app.Flight({flight_number: '191', origin: 'SYD', destination: 'TKO', airplane_id: 85})

    // new app.FlightShowView({model: flight});

    app.flight = app.flights.get(id);
    // console.log(app.flight);
    var view = new app.FlightShowView({model: app.flight});
    view.render();
  },

  getAirplanes: function() {
    console.log('you got airplanes');
    app.airplanes.fetch()
    var view = new app.AirplanesView({collection: app.airplanes});
    view.render();
  },

  getAirplane: function(id) {
    // app.airplanes.fetch().done( function(data) {
    //   console.log(a)
    //   var airplane = app.airplanes.get(id);
    //   var airplane = new app.Airplane({name: 'This is so freaking', rows: 5, cols: 20})
    app.airplane = app.airplanes.get(id);
    console.log(app.airplane)
    console.log(app.airplane);
    var view = new app.AirplaneShowView({model: app.airplane});
    view.render();
    //   console.log(data);
    // })
  },

  getReservations: function() {
    // console.log(app.reservations)
    var view = new app.ReservationsView({collection: app.reservations});
    view.render();
    console.log('you got reservations');
  },

  getReservation: function(id) {
    console.log('you got reservation' + id);
  },

  getUsers: function() {

  },

  getUser: function(id) {

  }
})