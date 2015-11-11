Meteor.methods
  reset: ->
    APP.collections.stocks.remove {}
    APP.collections.holdings.remove {}
    APP.collections.cash_status.remove {}

    stocks = [
      {
        _id: "CSCO"
        symbol: "CSCO"
        previous_price: 28.18
        price: 27.98
      }
      {
        _id: "AAPL"
        symbol: "AAPL"
        previous_price: 116.90
        price: 116.77
      }
      {
        _id: "CAT"
        symbol: "CAT"
        previous_price: 71.79
        price: 72.45
      }
      {
        _id: "KO"
        symbol: "KO"
        previous_price: 41.44
        price: 41.77
      }
      {
        _id: "GE"
        symbol: "GE"
        previous_price: 29.63
        price: 30.13
      }
      {
        _id: "GS"
        symbol: "GS"
        previous_price: 196.58
        price: 197.62
      }
      {
        _id: "INTC"
        symbol: "INTC"
        previous_price: 33.17
        price: 33.21
      }
      {
        _id: "IBM"
        symbol: "IBM"
        previous_price: 135.36
        price: 135.42
      }
    ]

    for stock in stocks
      APP.collections.stocks.insert stock

    holdings = [
      {
        _id: "CAT"
        amount: 200
      }
      {
        _id: "CSCO"
        amount: 350
      }
      {
        _id: "AAPL"
        amount: 130
      }
      {
        _id: "KO"
        amount: 121
      }
      {
        _id: "GE"
        amount: 350
      }
      {
        _id: "GS"
        amount: 10
      }
      {
        _id: "INTC"
        amount: 230
      }
      {
        _id: "IBM"
        amount: 90
      }
    ]

    for asset in holdings
      APP.collections.holdings.insert asset

    APP.collections.cash_status.insert
      total: 14000