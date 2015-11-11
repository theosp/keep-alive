Template.stocks_panel.events
  "change .stock-price": (e) ->
    APP.collections.stocks.update @_id, {$set: {price: $(e.target).val()}}

helpers = 
  stocks: -> APP.collections.stocks.find({})

Template.stocks_panel.helpers helpers