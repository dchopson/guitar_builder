require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'generates a random number for new records' do
    order = Order.new
    order.save!
    assert_not_nil order.number
  end
end
