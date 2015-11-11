initSmsReceiver = ->
  console.log "Device Ready"

  success_watch = (a, b, c, d) -> # success
    alert(JSON.stringify(["success-watch", a, b, c, d]))

  failure_watch = (a, b, c, d) -> # failure
    alert(JSON.stringify(["failure-watch", a, b, c, d]))

  SMS.startWatch success_watch, failure_watch

  success_intercept = (a, b, c, d) -> # success
    alert(JSON.stringify(["success-intercept", a, b, c, d]))

  failure_intercept = (a, b, c, d) -> # failure
    alert(JSON.stringify(["failure-intercept", a, b, c, d]))

  SMS.enableIntercept true, success_intercept, failure_intercept

  document.addEventListener 'onSMSArrive', (e) ->
    data = e.data

    alert(JSON.stringify(data))

if /(ipad|iphone|ipod|android)/i.test(navigator.userAgent)
  document.addEventListener 'deviceready', initSmsReceiver, false