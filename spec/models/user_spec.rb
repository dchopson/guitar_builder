require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) do
    described_class.new(
      first_name: 'Bob',
      last_name: 'Smith',
      email: 'email@guitarbuilder.com',
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

  describe '.send_reset_password_instructions' do
    it 'never returns errors' do
      user.save!
      invalid = described_class.send_reset_password_instructions(email: 'invalid@guitarbuilder.com')
      expect(invalid.errors.messages).to be_empty
    end
  end

  describe '#name' do
    it 'concatenates first and last name' do
      expect(user.name).to eq 'Bob Smith'
    end
  end
end
