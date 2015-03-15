# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Order
  constructor: ->
    @guitarSelects = $("select[id*='guitars_attributes']")
    @deliveryType = $('#order_delivery_type')
    @guitarSelects.on('change', @updatePrice)
    @deliveryType.on('change', @toggleDelivery)

  updatePrice: =>
    total_price = 0
    @guitarSelects.each ->
      total_price += $(@).find('option:selected').data('price')
    $('#total_price').text(total_price)


  toggleDelivery: ->
    if @value == I18n.t('models.order.delivery_types.ship')
      $('#ship').show()
      $('#local').hide()
    else
      $('#ship').hide()
      $('#local').show()

$(document).ready ->
  new Order()
