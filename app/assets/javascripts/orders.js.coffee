# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $deliveryType = $('#order_delivery_type')
  $deliveryType.change ->
    if @value == 'Ship'
      $('#ship').show()
      $('#local').hide()
    else
      $('#ship').hide()
      $('#local').show()

  $('select').change ->
    total_price = 0
    $("select[id*='guitars_attributes']").each ->
      total_price += $(this).find('option:selected').data('price')

    $('#total_price').text(total_price)
