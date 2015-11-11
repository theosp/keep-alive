Template.trade_panel.events
  "click .asset": (e) ->
    $(".focused").removeClass("focused")
    $(e.target).closest(".asset").addClass("focused")

  "click .sell": (e) ->
    if APP.helpers.connected()
      Meteor.call "sell", this.symbol
    else
      APP.helpers.sendSmsToServer "SELL #{this.symbol}"

      $(e.target).closest(".asset").remove()

      value = this.amount * this.price

      new_cash = value + parseInt($("#cash").html().replace(/,/g, ""), 10)

      $("#cash").html(APP.helpers.numberWithCommas(new_cash.toFixed 2))



helpers = 
  holdings: ->
    holdings = APP.collections.holdings.find().fetch()

    for asset in holdings
      stock_info = APP.collections.stocks.findOne {_id: asset._id}

      _.extend asset, stock_info

      asset.worth = asset.price * asset.amount

      asset.change_percent = ((asset.price / asset.previous_price) - 1) * 100

    holdings

  cash: ->
    cash_status = APP.collections.cash_status.findOne()

    if cash_status?
      return cash_status.total

    return 0

  cash_two_dec: ->
    helpers.cash().toFixed 2

  net_worth: ->
    worth = _.reduce helpers.holdings(), (memo, asset) ->
      memo + asset.worth
    , helpers.cash()

    worth.toFixed 2

Template.trade_panel.helpers helpers