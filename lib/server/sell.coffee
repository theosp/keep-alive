Meteor.methods
  sell: (symbol) ->
    holding = APP.collections.holdings.findOne(symbol)

    stock_info = APP.collections.stocks.findOne(symbol)

    value = holding.amount * stock_info.price

    APP.collections.cash_status.update {}, {$inc: {total: value}} 

    APP.collections.holdings.remove(symbol)