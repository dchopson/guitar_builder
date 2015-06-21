class Order < ActiveRecord::Base
  belongs_to :user
  has_many :guitars, dependent: :destroy
  accepts_nested_attributes_for :guitars

  i18n_scope = [:models, :order]

  DELIVERY_TYPES = {
    local: I18n.t('delivery_types.local', scope: i18n_scope),
    ship: I18n.t('delivery_types.ship', scope: i18n_scope)
  }

  STATUSES = {
    complete: I18n.t('statuses.complete', scope: i18n_scope),
    in_progress: I18n.t('statuses.in_progress', scope: i18n_scope),
    pending: I18n.t('statuses.pending', scope: i18n_scope)
  }

  HOLD_FEE = 50

  scope :pending, -> { where(status: STATUSES[:pending]) }
  scope :in_progress, -> { where(status: STATUSES[:in_progress]) }
  scope :created_today, -> { where(created_at: Date.today) }

  after_initialize :set_completion_date
  before_create :set_status, :set_number

  def self.method_missing(method, *args)
    order_const = Order.const_get(method.upcase)
    return order_const unless order_const.is_a?(Hash)
    order_const.map{|_,v| v}
  end

  def paid?
    purchased_at.present?
  end

  def price_in_cents
    price * 100
  end

  def express_token=(token)
    write_attribute(:express_token, token)
    if token.present?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params['first_name']
      self.last_name = details.params['last_name']
      #TODO address, telephone
    end
  end

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
