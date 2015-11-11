initSmsReceiver = ->
  console.log "Device Ready"

  success_watch = (a, b, c, d) -> console.log "Work"

  failure_watch = (a, b, c, d) -> console.log "Failed"

  SMS.startWatch success_watch, failure_watch

  success_intercept = (a, b, c, d) -> console.log "Suc"

  failure_intercept = (a, b, c, d) -> console.log "Fail"

  SMS.enableIntercept true, success_intercept, failure_intercept

  APP.modules or = {}
  APP.modules.SmsEmitter = ->
    EventEmitter.call @

    return @

  Util.inherits APP.modules.SmsEmitter, EventEmitter

  APP.modules.SmsEmitter = new APP.modules.SmsEmitter()

  document.addEventListener 'onSMSArrive', (e) ->
    data = e.data

    if data.body?
      req = data.body.split " "

      op = req[0]
      
      if op == "SELL"
        APP.modules.SmsEmitter.emit "sell", req[1]

      if op == "GET"
        APP.modules.SmsEmitter.emit "get", req[1], req[2]
      

if /(ipad|iphone|ipod|android)/i.test(navigator.userAgent)
  document.addEventListener 'deviceready', initSmsReceiver, false