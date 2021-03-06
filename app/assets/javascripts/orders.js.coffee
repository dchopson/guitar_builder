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
    $priceLabel = $('span#price')
    $priceLabel.text('$' + order_price)
    $('input[name="order[price]"]').val(order_price)

    max = @maxPrice.val()
    if max != '' && order_price > max
      $priceLabel.removeClass('label-success')
      $priceLabel.addClass('label-warning')
    else
      $priceLabel.removeClass('label-warning')
      $priceLabel.addClass('label-success')

  updateImage: ->
    imgId = @.id.replace(@.id.substr(0,27), '')
    $img = $('#' + imgId)
    $img.attr('src', '/assets/' + @.value + '.jpg')

$(document).on 'ready page:load', ->
  new Order()
