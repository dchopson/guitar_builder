require 'rails_helper'

RSpec.describe Order, :type => :model do
  describe 'associations' do
    xit { is_expected.to belong_to :user }
    it { is_expected.to have_many :guitars }
    it { is_expected.to accept_nested_attributes_for :guitars }
  end
  
  describe 'callbacks' do
    let(:order) { described_class.new }
    
    context 'initialize new' do
      it 'sets the completion date' do
        expect(order.completion_date).to_not be_nil
      end
    end
    
    context 'before create' do
      it 'sets the status' do
        order.save!
        expect(order.status).to_not be_nil
      end      
    end
  end
  
  describe '.method_missing' do
    context 'single-value constants' do
      it 'allows them to be called as methods' do
        expect(described_class.hold_fee).to eq(Order::HOLD_FEE)
      end
    end
    
    context 'hash constants' do
      it 'allows them to be called as methods & returns an array of values' do
        i18n_scope = [:models, :order]
        expect(described_class.delivery_types).to eq([
          I18n.t('delivery_types.local', scope: i18n_scope),
          I18n.t('delivery_types.ship', scope: i18n_scope)
        ])
      end
    end
  end
end
