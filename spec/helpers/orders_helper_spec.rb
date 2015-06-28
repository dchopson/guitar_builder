require 'rails_helper'

RSpec.describe OrdersHelper, :type => :helper do
  before :each do
    allow(helper).to receive_message_chain(:params, :[]).and_return(action)
  end

  describe '#creating?' do
    let(:action) { 'new' }

    it 'returns true when action is new' do
      expect(helper.creating?).to be true
    end
  end

  describe '#editing?' do
    let(:action) { 'edit' }

    it 'returns true when action is edit' do
      expect(helper.editing?).to be true
    end
  end

  describe '#viewing?' do
    let(:action) { 'show' }

    it 'returns true when action is show' do
      expect(helper.viewing?).to be true
    end
  end
end
