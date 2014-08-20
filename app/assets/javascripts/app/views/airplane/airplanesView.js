var app = app || {};

app.AirplanesView = Backbone.View.extend({
  el: '#main',
  initialize: function() {
    _.bindAll(this, 'render');
    this.collection.bind('add', this.render);
  },
  render: function(){
    var createAirplaneView = new app.AirplaneNewView();
    this.$el.html( createAirplaneView.render() )
    var viewAll = this;
    this.collection.each(function(model){
      var planeView = new app.AirplaneView({model: model});
      viewAll.$el.append( planeView.render() );
    })
  },
});