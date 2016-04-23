moment.locale 'ru'

millisecondsInDay = 86400 * 1000
strings =
  en:
    months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
  ru:
    months: ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август' , 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь']

module.exports =
  today: ->
    new Date

  dateString: (date) ->
    year = date.getFullYear()
    month = date.getMonth() + 1
    day = date.getDate()
    month = '0' + month if month < 10
    day = '0' + day if day < 10
    "#{year}-#{month}-#{day}"

  prevDate: (date) ->
    new Date date.getTime() - millisecondsInDay

  nextDate: (date) ->
    new Date date.getTime() + millisecondsInDay

  formatMonthAndDay: (date) ->
    format = if @lang is 'ru' then "D MMMM" else "MMMM D"
    moment(date).format(format)

  lang: 'ru'

  t: (key) ->
    strings[@lang][key]

  toggleButton: (button) ->
    $(button).find('i').toggleClass('filled')

  render: (template, args...) ->
    @templates ?= require.context("../templates", true, /\.hbs$/)
    @templates("./#{template}.hbs")(args...)

  # whenAllDone: (promises..., next) ->
  #   hasNullPromises = promises.some (p) -> p is null or p is undefined
  #   Promise.all(promises).then(next)

window.__console_ins = (arg) -> console.log(arg)
window.__console_ins_arr = (args) -> console.log(arg) for arg in args
