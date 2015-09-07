# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Order
  constructor: ->
    @maxPrice = $('#max_price')
    @guitarSelects = $("select[id*='guitars_attributes']")
    @bindEvents()
    @guitarSelects.change()

  bindEvents: =>
    @maxPrice.change(@updatePrice)
    @guitarSelects.change(@updatePrice)
    @guitarSelects.change(@updateImage)

  updatePrice: =>
    order_price = 0
    @guitarSelects.each ->
      order_price += $(@).find('option:selected').data('price')
    $('#order_price').val(order_price)

    $priceWarning = $('#price-warning')
    max = @maxPrice.val()
    if max > 0 && order_price > max
      $priceWarning.text(I18n.t('views.orders.form.max_price_exceeded'))
      $priceWarning.show()
    else
      $priceWarning.hide()

  updateImage: ->
    imgId = @.id.replace(@.id.substr(0,27), '')
    $img = $('#' + imgId)
    $img.attr('src', '/assets/' + @.value + '.jpg')

$(document).on 'ready page:load', ->
  new Order()
