require 'rails_helper'

RSpec.describe Order, :type => :model do
  describe 'associations' do
    xit { is_expected.to belong_to :user }
  end
  
  describe '.before_create' do
    let(:order) { described_class.new }
    
    before :each do
      order.save!
    end
    
    it 'sets the completion date before create' do
      expect(order.completion_date).to eq(Date.today + 1.days)
    end
    
    it 'sets the status before create' do
      expect(order.status).to eq(Order::STATUSES[:pending])
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
