# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Order
  constructor: ->
    @maxPrice = $('#max_price')
    @guitarSelects = $("select[id*='guitars_attributes']")
    @deliveryType = $('#order_delivery_type')
    @bindEvents()
    @updatePrice()

  bindEvents: =>
    @maxPrice.on('change', @updatePrice)
    @guitarSelects.on('change', @updatePrice)
    @deliveryType.on('change', @toggleDelivery)

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

  toggleDelivery: ->
    if @value == I18n.t('models.order.delivery_types.ship')
      $('#ship').show()
      $('#local').hide()
    else
      $('#ship').hide()
      $('#local').show()

$(document).on 'ready page:load', ->
  new Order()
