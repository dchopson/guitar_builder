require 'rails_helper'

RSpec.describe Name do
  subject { Order.new(first_name: 'Bob', last_name: 'Smith') }

  describe '#name' do
    it 'concatenates first and last name' do
      expect(subject.name).to eq 'Smith, Bob'
    end
  end
end
