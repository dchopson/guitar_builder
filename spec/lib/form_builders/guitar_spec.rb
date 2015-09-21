require 'rails_helper'

RSpec.describe FormBuilders::Guitar do
  let(:guitar) { Guitar.new }
  let(:view) { ActionView::Base.new }

  subject { described_class.new(:guitar, guitar, view, {}) }

  describe '#select' do
    let(:select) { subject.select(:body_wood) }

    it 'adds a thumbnail image' do
      expect(select).to include '<img alt="Placeholder"'
    end

    it 'adds the correct options from the Guitar class' do
      Guitar.body_woods.each do |body_wood|
        expect(select).to include body_wood.first
      end
    end

    it 'preselects persisted values' do
      guitar.body_wood = 'cherry'
      guitar.save(validate: false)
      expect(select).to include 'selected="selected" value="cherry"'
    end
  end

  describe '#checkbox' do
    let(:checkbox) { subject.checkbox(:pick_guard) }

    it 'adds a question mark to the label' do
      expect(checkbox).to include 'Pick guard?'
    end
  end
end
