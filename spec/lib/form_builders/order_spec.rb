require 'rails_helper'

RSpec.describe FormBuilders::Order do
  let(:order) { Order.new }
  let(:view) { ActionView::Base.new }

  subject { described_class.new(:order, order, view, {}) }

  describe '#select' do
    let(:select) { subject.select(:status) }

    it 'adds the correct options from the Order class' do
      Order.statuses.each do |status|
        expect(select).to include status.first
      end
    end
  end

  describe '#user_select' do
    it 'adds all users as options' do
      user = User.create!(
        first_name: 'Bob',
        last_name: 'Smith',
        email: 'email@guitarbuilder.com',
        password: 'password',
        password_confirmation: 'password',
      )
      expect(subject.user_select).to include user.name
    end
  end

  describe '#text_field' do
    it 'is not readonly by default' do
      expect(subject.text_field(:first_name)).to_not include 'readonly'
    end

    it 'is readonly when true is passed' do
      expect(subject.text_field(:first_name, true)).to include 'readonly'
    end
  end
end
