require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) do
    described_class.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'email@example.com',
      password: 'password',
      password_confirmation: 'password',
    )
  end

  describe 'associations' do
    it { is_expected.to have_many :orders }
  end

  describe '.all_for_select' do
    it 'returns an array of arrays with name and id' do
      user.save!
      expect(described_class.all_for_select).to eq([[user.name, user.id]])
    end
  end

  describe '#name' do
    it 'concatenates first and last name' do
      expect(user.name).to eq 'Bob Smith'
    end
  end
end
