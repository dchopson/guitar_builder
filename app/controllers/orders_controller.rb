class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :new, :create, :status]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @guitar = @order.guitars.new
  end

  # GET /orders/1/edit
  def edit
  end

  # GET /orders/status
  def status
    order = Order.find_by number: params[:number], email: params[:email]
    if order
      redirect_to order
    else
      redirect_to welcome_index_path, alert: I18n.t('views.welcome.index.no_order_found')
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      redirect = current_user ? @order : welcome_index_path
      if @order.save
        format.html { redirect_to redirect, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(
    :number,
    :completion_date,
    :status,
    :delivery_type,
    :first_name,
    :last_name,
    :address,
    :telephone,
    :email,
    :cc_number,
    :user_id,
    :lock_version,
    guitars_attributes: [
      :id,
      :body_style,
      :body_wood,
      :body_finish,
      :pick_guard,
      :fretboard_wood,
      :fretboard_finish,
      :fretboard_markers,
      :neck_wood,
      :neck_finish,
      :tuning_peg_style,
      :tuning_peg_layout,
      :string_type
    ])
  end
end
