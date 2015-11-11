Template.trade_panel.events
  "click .asset": (e) ->
    $(".focused").removeClass("focused")
    $(e.target).closest(".asset").addClass("focused")

  "click .refresh-container": (e) ->
    if not APP.helpers.connected()
      $asset = $(e.target).closest(".asset")
      $asset.find(".fa-refresh").addClass("fa-spin")

      APP.helpers.sendSmsToServer "GET #{this.symbol}" 

      APP.modules.SmsEmitter.once "get", (symbol, price) =>
        $asset.find(".fa-refresh").removeClass("fa-spin")
        $asset.find(".price").html(price)

        prev_value = @amount * @price

        new_value = @amount * price

        change_percent = ((price / @previous_price) - 1) * 100

        $asset.find(".badge").html("#{change_percent.toFixed 2}%")

        $asset.find(".value").html(APP.helpers.numberWithCommas(new_value))

        current_netwt = parseInt($(".net-wt").html().replace(/,/g, ""), 10)

        new_netwt = current_netwt - prev_value + new_value

        $(".net-wt").html(APP.helpers.numberWithCommas(new_netwt.toFixed 2))

  "click .sell": (e) ->
    if confirm "Are you sure you want to sell all your #{this.symbol} holding?"
      if APP.helpers.connected()
        Meteor.call "sell", this.symbol
      else
        APP.helpers.sendSmsToServer "SELL #{this.symbol}"
        $(e.target).html("Selling...")

        APP.modules.SmsEmitter.once "sell", (symbol) =>
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