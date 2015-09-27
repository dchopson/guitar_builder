require 'rails_helper'

RSpec.describe OrdersController, :type => :controller do
  let(:order) do
    mock_model(Order,
               id: 1,
               number: '1234',
               email: 'email@guitarbuilder.com',
               price_in_cents: 5000,
               paid?: false)
  end
  let(:address) { '123 Main St.' }

  context 'user logged in' do
    let(:user) do
      User.create(
        email: 'email@guitarbuilder.com',
        password: 'password',
        password_confirmation: 'password',
      )
    end

    before :each do
      sign_in user
    end

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
      before :each do
        allow(Order).to receive(:find).and_return(order)
      end

      it 'responds successfully' do
        get :show, id: order
        expect(response).to be_success
      end

      context 'when there is an express token and the order is not paid' do
        let(:token) { '1234' }

        it 'completes the purchase' do
          expect(order).to receive(:update_attribute).with(:express_token, token)
          expect(order).to receive(:purchase!)
          get :show, id: order, token: token
        end
      end
    end

    describe '#express' do
      it 'sets up the purchase & redirects' do
        allow(Order).to receive(:find).and_return(order)
        expect(EXPRESS_GATEWAY).to receive(:setup_purchase).and_return(double(token: 1234))
        expect(EXPRESS_GATEWAY).to receive(:redirect_url_for).and_return(orders_path)
        get :express, id: order
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
        it 'redirects to orders_path' do
          patch :update, id: order, order: { address: order.address }
          expect(response).to redirect_to(orders_path)
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

  context 'no user logged in' do
    describe 'member actions' do
      context 'number and email params passed' do
        let(:number) { '1234' }
        let(:email) { 'email@guitarbuilder.com' }

        it 'looks up the order' do
          expect(Order).to receive(:find_by).with(number: number, email: email)
          get :show, number: number, email: email
        end
      end

      context 'no order found' do
        it 'redirects to welcome index' do
          get :show
          expect(flash[:alert]).to eq I18n.t('views.welcome.index.no_order_found')
          expect(response).to redirect_to(welcome_index_path)
        end
      end
    end
  end
end
