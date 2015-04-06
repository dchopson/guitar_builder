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
    total_price = 0
    @guitarSelects.each ->
      total_price += $(@).find('option:selected').data('price')
    $('#total_price').text(I18n.t('number.currency.format.unit') + total_price)

    $priceWarning = $('#price-warning')
    max = @maxPrice.val()
    if max > 0 && total_price > max
      $priceWarning.text("You've exceeded your maximum price")
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
