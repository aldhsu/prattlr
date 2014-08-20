var app = app || {};

// search and result underneath
app.FlightSearchView = Backbone.View.extend({
  el: '#main',

  initialize: function() {
    // binding listener for add to collection
    _.bindAll(this, 'render');
    this.collection.bind('add', this.render);
  },

  render: function() {

    var template = Handlebars.compile(app.templates.flightSearchView);
    var view_html = template({models: this.collection.models})
    this.$el.html(view_html);
    return this;
  },
  events: {
    'submit': 'submitFlight'
  },

  submitFlight: function(event) {
    event.preventDefault();
    // select from current collection - dirty hack you should fetch at this point
    var mainView = this
    var $flightsResultsView = mainView.$el.find('#flight-results')
    $flightsResultsView.html('');
    $flightsResultsView.html(app.templates.flightsView);
    var selectedFlights = this.collection.where({origin: $('#flight-start-dropdown option:selected').val(), destination: $('#flight-end-dropdown option:selected').val()});
    _.each(selectedFlights, function(flight) {
      // debugger;
      var view = new app.FlightView({model: flight});
      $flightsResultsView.append(view.render());
    });
  }
})