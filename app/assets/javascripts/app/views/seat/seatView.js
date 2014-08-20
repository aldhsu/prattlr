var app = app || {};

app.SeatView = Backbone.View.extend({
  tagName: 'div',
  className: 'seat booked',
  initialize: function() {
  },
  render: function() {
    this.$el.html( app.templates.seatView )
    return this.el;
  }
});