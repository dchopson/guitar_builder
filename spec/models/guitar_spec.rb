require 'rails_helper'

RSpec.describe Guitar, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to :order }
  end

  describe '.method_missing' do
    it 'allows hash constants to be called as methods & returns an array of values' do
      expect(described_class.body_styles).to include({
        value: I18n.t('models.guitar.body_styles.cutaway'),
        data: {price: 10}
      })
    end
  end
end
