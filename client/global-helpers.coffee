_.extend APP.helpers,
  sendSmsToServer: (message) ->
    console.log "Sending"

    options = {}

    success = ->
      console.log "Sent"

    error = ->
      console.log "Error"

    sms.send APP.config.server_number, message, options, success, error

  allowAccess: ->
    Session.set("allowed", true)
    amplify.store("allowed", true)

template_helpers =
  stringify: (x) -> JSON.stringify x
  connected: -> Meteor.status().connected
  numberWithCommas: (x) -> x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
  twoDec: (x) -> x.toFixed 2
  isNegative: (x) -> x < 0
  isCordova: -> Meteor.isCordova
  permission_granted: -> template_helpers.isCordova() or Session.get("allowed") or amplify.store("allowed")

# Make template helpers also available as app helpers
_.extend APP.helpers, template_helpers

for helper_name, helper of template_helpers
  Template.registerHelper helper_name, helper