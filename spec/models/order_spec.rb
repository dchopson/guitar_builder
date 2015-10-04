require 'rails_helper'

RSpec.describe Order, :type => :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
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

      it 'sets the number' do
        order.save!
        expect(order.number).to_not be_nil
      end
    end
  end

  describe 'validations' do
    it 'validates that price matches selected options' do
      guitar = subject.guitars.build
      allow(guitar).to receive(:total_of_selected).and_return(40)
      subject.price = 50
      subject.valid?
      expect(subject.errors[:price]).to include('does not match selected options')
    end
  end

  describe '.method_missing' do
    it 'allows hash constants to be called as methods & returns an array of values' do
      i18n_scope = [:models, :order]
      expect(described_class.statuses).to eq([
        I18n.t('statuses.complete', scope: i18n_scope),
        I18n.t('statuses.in_progress', scope: i18n_scope),
        I18n.t('statuses.pending', scope: i18n_scope)
      ])
    end
  end

  describe 'instance methods' do
    subject { described_class.new(price: 50) }

    describe '#name' do
      it 'concatenates first and last name' do
        subject.first_name = 'Bob'
        subject.last_name = 'Smith'
        expect(subject.name).to eq 'Smith, Bob'
      end
    end

    describe '#paid?' do
      it 'returns false when there is not a purchased_at date' do
        expect(subject.paid?).to be_falsey
      end

      it 'returns true when there is a purchased_at date' do
        subject.purchased_at = Date.today
        expect(subject.paid?).to be_truthy
      end
    end

    describe '#price_in_cents' do
      it 'returns the price in cents' do
        expect(subject.price_in_cents).to eq(5000)
      end
    end

    describe '#express_token=' do
      let(:params) do
        {
          first_name: 'Bob',
          last_name: 'Smith',
          phone: '770-777-7777',
          street1: '123 Main St.',
          street2: 'Apt 101',
          city_name: 'Omaha',
          state_or_province: 'NE',
          postal_code: '11111',
          country_name: 'United States'
        }
      end
      let(:details) { double(payer_id: 'ABC', params: params)}

      before :each do
        allow(EXPRESS_GATEWAY).to receive(:details_for).and_return(details)
        subject.express_token = '1234'
      end

      it 'sets the token' do
        expect(subject.express_token).to eq('1234')
      end

      it 'sets additional attributes' do
        expect(subject.first_name).to eq params[:first_name]
        expect(subject.last_name).to eq params[:last_name]
        expect(subject.telephone).to eq params[:phone]
        expect(subject.address).to eq "123 Main St.\nApt 101\nOmaha, NE 11111\nUnited States"
      end
    end

    describe '#purchase!' do
      before { allow(EXPRESS_GATEWAY).to receive(:purchase).and_return(double(success?: success)) }

      context 'gateway purchase succeeds' do
        let(:success) { true }

        it 'returns true and sets purchased_at' do
          expect(subject.purchase!).to be_truthy
          expect(subject.purchased_at).to be_within(30.seconds).of DateTime.now
        end
      end

      context 'gateway purchase fails' do
        let(:success) { false }

        it 'returns false' do
          expect(subject.purchase!).to be_falsey
        end
      end
    end
  end
end
