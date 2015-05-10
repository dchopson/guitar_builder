require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:order) { mock_model(Order, id: 1) }
  let(:address) { '123 Main St.' }

  describe '#index' do
    before :each do
      get :index
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'assigns @orders' do
      expect(assigns(:orders)).to_not be_nil
    end
  end

  describe '#show' do
    it 'responds successfully' do
      allow(Order).to receive(:find).and_return(order)
      get :show, id: order
      expect(response).to be_success
    end
  end

  describe '#new' do
    before :each do
      get :new
    end

    it 'responds successfully' do
      expect(response).to be_success
    end

    it 'assigns @order' do
      expect(assigns(:order)).to_not be_nil
    end
  end

  describe '#edit' do
    it 'responds successfully' do
      allow(Order).to receive(:find).and_return(order)
      get :edit, id: order
      expect(response).to be_success
    end
  end

  describe '#status' do
    context 'order found' do
      it 'redirects to order path' do
        allow(Order).to receive(:find_by).and_return(order)
        get :status, number: '1', email: 'email@example.com'
        expect(response).to redirect_to(order_path(order))
      end
    end

    context 'order not found' do
      it 'redirects to welcome index path with an alert' do
        get :status, number: '1', email: 'email@example.com'
        expect(flash[:alert]).to eq I18n.t('views.welcome.index.no_order_found')
        expect(response).to redirect_to(welcome_index_path)
      end
    end
  end

  describe '#create' do
    context 'success' do
      it 'creates an order' do
        expect{post :create, order: { address: address }}.to change{Order.count}.by(1)
      end

      it 'redirects to order_path' do
        post :create, order: { address: address }
        expect(response).to redirect_to(order_path(assigns(:order)))
      end
    end

    context 'failure' do
      before :each do
        allow_any_instance_of(Order).to receive(:save).and_return(false)
      end

      it 'renders new' do
        post :create, order: { address: address }
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    let(:order) { Order.create }

    before :each do
      allow(Order).to receive(:find).and_return(order)
    end

    context 'success' do
      it 'redirects to order_path' do
        patch :update, id: order, order: { address: order.address }
        expect(response).to redirect_to(order_path(assigns(:order)))
      end
    end

    context 'failure' do
      before :each do
        allow_any_instance_of(Order).to receive(:update).and_return(false)
      end

      it 'renders edit' do
        patch :update, id: order, order: { address: order.address }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    before :each do
      @order = Order.create
    end

    it 'destroys an order' do
      expect{delete :destroy, id: @order}.to change{Order.count}.by(-1)
    end

    it 'redirects to orders_path' do
      delete :destroy, id: @order
      expect(response).to redirect_to(orders_path)
    end
  end
end
