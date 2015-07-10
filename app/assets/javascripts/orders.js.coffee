# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Order
  constructor: ->
    @maxPrice = $('#max_price')
    @guitarSelects = $("select[id*='guitars_attributes']")
    @bindEvents()
    @updatePrice()
    @setupAnimations()

  setupAnimations: ->
    $draggable = $('.draggable')

    $draggable.draggable({
      revert: (event, ui) ->
        $(@).data('ui-draggable').originalPosition = {
          top: 0,
          left: 0
        }
        !event;
    })

    $draggable.each ->
      id = $(@).attr('id')
      $(@).css('background-image', "url('/assets/" + id + ".jpg')")

    $('.droppable').droppable({
      activeClass: 'ui-state-default',
      hoverClass: 'ui-state-hover',
      drop: (event, ui) ->
        $(@).val(ui.draggable[0].id)
        # TODO @updatePrice
        ui.draggable.position({
          my: 'center',
          at: 'center',
          of: @
        })
    })

  bindEvents: =>
    @maxPrice.on('change', @updatePrice)
    @guitarSelects.on('change', @updatePrice)

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

$(document).on 'ready page:load', ->
  new Order()
