require 'rails_helper'

RSpec.describe Guitar, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to :order }
  end

  describe '.method_missing' do
    it 'allows hash constants to be called as methods & returns an array of values' do
      i18n_scope = [:models, :guitar]
      expect(described_class.body_styles).to eq([
        [I18n.t('body_styles.cutaway', scope: i18n_scope), 10],
        [I18n.t('body_styles.full', scope: i18n_scope), 5],
        [I18n.t('body_styles.half_cutaway', scope: i18n_scope), 15]
      ])
    end
  end
end
