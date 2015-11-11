qs = Npm.require('querystring')

WebApp.connectHandlers.use "/twilio", (req, res, next) ->
  if req.method == 'POST'
    body = ''
    req.on 'data', Meteor.bindEnvironment (data) ->
      body += data
      # 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
      if body.length > 1e6
        # FLOOD ATTACK OR FAULTY CLIENT, NUKE req
        req.connection.destroy()
      return
    req.on 'end', Meteor.bindEnvironment ->
      POST = qs.parse(body)

      [op, symbol] = POST.Body.split(" ")

      if op == "GET"
        res_body = "GET #{symbol} " + APP.collections.stocks.findOne(symbol).price

      if op == "SELL"
        Meteor.call "sell", symbol

        res_body = "SELL #{symbol}"

      res.writeHead 200,
        'Content-Type': 'text/xml'

      response = """
        <?xml version=\"1.0\" encoding=\"UTF-8\"?>
        <Response><Message>#{res_body}</Message></Response>
      """

      res.end response

  else
    res.end("POST Required")