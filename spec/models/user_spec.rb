require 'rails_helper'

RSpec.describe User, :type => :model do
  describe 'associations' do
    it { is_expected.to have_many :orders }
  end

  describe '#name' do
    let(:user) { described_class.new(first_name: 'Bob', last_name: 'Smith') }

    it 'concatenates first and last name' do
      expect(user.name).to eq 'Bob Smith'
    end
  end
end
