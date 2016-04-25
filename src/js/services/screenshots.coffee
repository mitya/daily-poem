class Poems.Services.Screenshots
  enable: ->
    $(document).click (e) =>
      [x, y] = [e.pageX, e.pageY]
      # return unless y < 100
      @performNextTestAction()

  performNextTestAction: ->
    @actions ?= [
      =>
        Router.go("poems/6")
      =>
        App.f7app.openPanel('left')
      =>
        App.f7app.closePanel()
        Router.go("favorites")
    ]
    @lastActionIndex ?= 0
    action = @actions[@lastActionIndex++]
    action && action()
