require 'rails_helper'

RSpec.describe Guitar, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to :order }
  end

  describe '.method_missing' do
    it 'allows hash constants to be called as methods & returns an array of values' do
      expect(described_class.body_styles).to include([
        I18n.t('models.guitar.body_styles.cutaway'),
        :cutaway,
        {data: {price: 10}}
      ])
    end
  end

  describe '#total_of_selected' do
    it 'returns the total price of selected options' do
      subject.body_style = :cutaway
      subject.body_wood = :cherry
      subject.body_finish = :raw
      subject.fretboard_wood = :black_cherry
      subject.fretboard_finish = :raw
      subject.neck_wood = :pine
      subject.neck_finish = :gloss
      subject.tuning_peg_style = :square
      subject.tuning_peg_layout = :one_side
      subject.string_type = :steel
      expect(subject.total_of_selected).to eq 90
    end
  end
end
