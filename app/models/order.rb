class Order < ActiveRecord::Base
  belongs_to :user
  
  STATUSES = {
    pending: 'Pending', 
    in_progress: 'In Progress', 
    complete: 'Complete'
  }
  
  scope :pending, -> { where(status: STATUSES[:pending]) }
  scope :in_progress, -> { where(status: STATUSES[:in_progress]) }
  
  after_initialize :set_completion_date
  before_create :set_status
  
  # TODO generate a random number for each order
  # before_create :generate_random_number
  
  private
  
  def set_completion_date
    wait_time = Order.pending.count + Order.in_progress.count + 1
    self.completion_date = Date.today + wait_time.days
  end
  
  def set_status
    self.status = STATUSES[:new]
  end
  
  # def generate_random_number
    # random = SecureRandom.base64(8)
  # end
end
