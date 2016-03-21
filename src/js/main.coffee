require "framework7"
window.$$ = Dom7
window.$ = require "jquery"
window.Handlebars = require "handlebars/runtime"
window.Handlebars.registerHelper require "./helpers"
require 'hammerjs'

require "../css/main.scss"
require "../about.html"
require "../demo.html"

window.Poems = {}
window.Util = require "./util"
require "./model"
require "./app"
require "./router"
require './main_view'

$ ->
  window.Model = new Poems.Model
  window.App = new Poems.App
  window.Router = new Poems.Router
