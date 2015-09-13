require 'rails_helper'

RSpec.describe GuitarFormBuilder do
  let(:guitar) { Guitar.new }
  let(:view) { ActionView::Base.new }

  subject { described_class.new(:guitar, guitar, view, {}) }

  describe '#guitar_select' do
    let(:guitar_select) { subject.guitar_select(:body_wood) }

    it 'adds a thumbnail image' do
      expect(guitar_select).to include '<img alt="Placeholder"'
    end

    it 'adds the correct options from the Guitar class' do
      Guitar.body_woods.each do |body_wood|
        expect(guitar_select).to include body_wood.first
      end
    end

    it 'preselects persisted values' do
      guitar.body_wood = 'cherry'
      guitar.save(validate: false)
      expect(guitar_select).to include 'selected="selected" value="cherry"'
    end
  end

  describe '#user_select' do
    it 'adds all users as options' do
      user = User.create!(
        first_name: 'Bob',
        last_name: 'Smith',
        email: 'email@example.com',
        password: 'password',
        password_confirmation: 'password',
      )
      expect(subject.user_select).to include user.name
    end
  end

  describe '#guitar_checkbox' do
    let(:guitar_checkbox) { subject.guitar_checkbox(:pick_guard) }

    it 'adds a question mark to the label' do
      expect(guitar_checkbox).to include 'Pick guard?'
    end
  end

  #TODO create OrderFormBuilder and share methods with a module
  describe '#order_select' do
    let(:order_select) { subject.order_select(:status) }

    it 'adds the correct options from the Order class' do
      Order.statuses.each do |status|
        expect(order_select).to include status.first
      end
    end

    # it 'preselects persisted values' do
    #   guitar.body_wood = 'cherry'
    #   guitar.save(validate: false)
    #   expect(guitar_select).to include 'selected="selected" value="cherry"'
    # end
  end
end
