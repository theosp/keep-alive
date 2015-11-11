Template.header.events
  "click #reset": (e) ->
    Meteor.call "reset", ->
      console.log "done"
      location.reload()