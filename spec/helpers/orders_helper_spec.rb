require 'rails_helper'

RSpec.describe OrdersHelper, :type => :helper do
  describe '#editing?' do
    before :each do
      allow(helper).to receive_message_chain(:params, :[]).and_return(action)
    end
    
    context 'when action is edit' do
      let(:action) { 'edit' }
      
      it 'returns true' do
        expect(helper.editing?).to be true        
      end
    end
    
    context 'when action is not edit' do
      let(:action) { 'new' }
      
      it 'returns false' do
        expect(helper.editing?).to be false        
      end
    end
  end
end
