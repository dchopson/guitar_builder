class Order < ActiveRecord::Base
  belongs_to :user
  has_many :guitars, dependent: :destroy
  accepts_nested_attributes_for :guitars

  i18n_scope = [:models, :order]

  STATUSES = {
    complete: I18n.t('statuses.complete', scope: i18n_scope),
    in_progress: I18n.t('statuses.in_progress', scope: i18n_scope),
    pending: I18n.t('statuses.pending', scope: i18n_scope)
  }

  scope :pending, -> { where(status: STATUSES[:pending]) }
  scope :in_progress, -> { where(status: STATUSES[:in_progress]) }
  scope :created_today, -> { where(created_at: Date.today) }

  after_initialize :set_completion_date
  before_create :set_status, :set_number

  validate :price_matches_options

  def self.method_missing(method, *args)
    order_const = Order.const_get(method.upcase)
    return order_const unless order_const.is_a?(Hash)
    order_const.map{|_,v| v}
  end

  # @return [Boolean] is the order paid for?
  def paid?
    purchased_at.present?
  end

  # @return [Integer] the price converted from dollars to cents
  def price_in_cents
    price * 100
  end

  # Sets the token value. Retrieves additional buyer attributes from the gateway
  # and sets them as well
  # @param token [String] the token received from PayPal
  def express_token=(token)
    write_attribute(:express_token, token)
    if token.present?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id

      params = details.params.with_indifferent_access
      # self.email = params[:payer]
      self.first_name = params[:first_name]
      self.last_name = params[:last_name]
      self.telephone = params[:phone]
      self.address = "#{params[:street1]}; "\
        "#{"#{params[:street2]}; " if params[:street2]}"\
        "#{params[:city_name]}, #{params[:state_or_province]} #{params[:postal_code]}; "\
        "#{params[:country_name]}"
    end
  end

  # Completes the purchase on the PayPal side
  # @return [Boolean] was the purchase successful?
  def purchase!
    response = process_purchase
    update_attribute(:purchased_at, DateTime.now) if response.success?
    response.success?
  end

  private

  def set_completion_date
    if self.new_record?
      wait_time = Order.pending.count + Order.in_progress.count + 15
      self.completion_date = Date.today + wait_time.days
    end
  end

  def set_status
    self.status = STATUSES[:pending]
  end

  def set_number
    random = SecureRandom.urlsafe_base64(6)
    random.gsub('-', 'a')
    random.gsub('_', '9')
    self.number = random.upcase
  end

  # TODO assumes 1 guitar per order
  def price_matches_options
    unless guitars.all? {|g| g.total_of_selected == price}
      errors.add(:price, 'does not match selected options')
    end
  end

  def process_purchase
    EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
  end

  def express_purchase_options
    {
      # :ip => ip_address,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end
end
