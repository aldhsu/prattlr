var app = app || {};

app.Airplanes = Backbone.Collection.extend({
  url: '/airplanes',
  model: app.Airplane,
  initialize: function(){
  }
});