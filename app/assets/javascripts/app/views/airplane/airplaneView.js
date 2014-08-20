var app = app || {};

// Single row airplane
app.AirplaneView = Backbone.View.extend({
  tagName: 'div',
  events: {
    'click': 'view'
  },
  initialize: function() {
    _.bindAll(this, 'render');
    this.model.bind('change', this.render);
  },
  render: function() {
    var airplaneHTML = Handlebars.compile( app.templates.airplaneView );
    var copy = airplaneHTML( this.model.toJSON() );
    this.$el.append( copy );
    return this.el;
  },
  view: function(){
     app.router.navigate('airplanes/' + this.model.get('id'), true );
  }

});