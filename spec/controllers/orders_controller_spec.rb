require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:order) { stub_model(Order) }
  
  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_success      
    end
    
    # it ''
  end
end
