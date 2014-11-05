window.NorbertCronin = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils: {},
  
  initialize: function(options) {
    new NorbertCronin.Routers.Router({
      $rootEl: options.$main
    });
    Backbone.history.start();
    
    
  }
};