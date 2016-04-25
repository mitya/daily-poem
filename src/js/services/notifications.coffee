class Poems.Services.Notifications
  setReminders: =>
    notifications = cordova?.plugins.notification.local
    return unless notifications?

    console.time "setting up notifications"
    notifications.cancelAll()

    Model.closestPoems 7, (poems) =>
      for poem, index in poems
        notifications.schedule
          id: poem.id
          badge: 1
          at: poem.notificationTime()
          # at: Date.now() + (index + 1) * 1000 * 30
          text: poem.headingWithAuthor()
          data: poem_id: poem.id

      notifications.on "schedule", (notification) ->
        console.log "notification scheduled #{notification.id}", notification

      notifications.on "trigger", (notification) ->
        console.log "notification triggered #{notification.id}", notification

      notifications.on "click", (notification) ->
        notifications.clearAll()
        Router.go "poems/#{notification.id}"
        console.log "notification clicked #{notification.id}", notification, notification.data

    console.timeEnd "setting up notifications"

  clearAll: ->
    cordova?.plugins.notification.local.clearAll()
